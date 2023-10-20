import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class WithdrawalPwdLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final pwdCtrl = TextEditingController();
  final confirmPwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final confirmNewPwdCtrl = TextEditingController();
  final oldPwdCtrl = TextEditingController();
  final isWithdrawalPwdSet = false.obs;
  late String appBarTitle;

  @override
  void onInit() {
    isWithdrawalPwdSet.value =
        indexLogic.profile.value.isWithdrawPasswordSet == 1 ? true : false;


    super.onInit();
  }

  void setWithdrawalPwd() {
    if (pwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPassword);
      return;
    }
    if (pwdCtrl.text != confirmPwdCtrl.text) {
      AppWidget.showToast(Globe.pwdNotMatch);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final suc = await Apis.setWithdrawalPwd(
          pwd: pwdCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back(); // first times back to user-settings
          Get.back(); // second times back to mine
        }
      } catch (e, s) {
        Logger.print('withdrawal e: $e $s');
      }
    });

    Logger.print('clicked login password');
  }

  void modifyWithdrawalPwd() {
    if (newPwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterNewPwd);
      return;
    }
    if (oldPwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterOldPwd);
      return;
    }
    if (newPwdCtrl.text != confirmNewPwdCtrl.text) {
      AppWidget.showToast(Globe.pwdNotMatch);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final suc = await Apis.changeWithdrawalPwd(
          oldPwd: oldPwdCtrl.text,
          newPwd: newPwdCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('withdrawal e: $e $s');
      }
    });
    Logger.print('clicked login password');
  }

  @override
  void onClose() {
    pwdCtrl.dispose();
    confirmPwdCtrl.dispose();
    newPwdCtrl.dispose();
    confirmNewPwdCtrl.dispose();
    oldPwdCtrl.dispose();
    super.onClose();
  }
}
