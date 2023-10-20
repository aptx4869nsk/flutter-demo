import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/utils/data_sp.dart';

class LoginPwdLogic extends GetxController {
  final newPwdCtrl = TextEditingController();
  final confirmNewPwdCtrl = TextEditingController();
  final oldPwdCtrl = TextEditingController();

  void modifyLoginPwd() {
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
        final suc = await Apis.changeLoginPwd(
          oldPwd: oldPwdCtrl.text,
          newPwd: newPwdCtrl.text,
        );
        if (suc) {
          await DataSp.removeLoginCertificate();
          AppNavigator.startLogin();
        }
      } catch (e, s) {
        Logger.print('login pwd e: $e $s');
      }
    });

    Logger.print('clicked login password');
  }

  @override
  void onClose() {
    newPwdCtrl.dispose();
    confirmNewPwdCtrl.dispose();
    oldPwdCtrl.dispose();
    super.onClose();
  }
}
