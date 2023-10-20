import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/widgets/app_widget.dart';

class WalletLogic extends GetxController {
  final amountCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final indexLogic = Get.find<IndexLogic>();
  final remainingBalance = ''.obs; // 余额宝

  @override
  void onInit() {
    remainingBalance.value = indexLogic.profile.value.canWithdrawBalance ?? '--';
    super.onInit();
  }

  void walletToPointsSwap() {
    if(amountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterDepositAmt);
      return;
    }
    if(pwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPassword);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        await Apis.walletToPointsSwap(
          amount: amountCtrl.text,
          password: pwdCtrl.text,
        );
        indexLogic.getProfile();
        Get.back();
        Get.back();
      } catch (e, s) {
        Logger.print('wallet e: $e $s');
      }
    });
  }
}
