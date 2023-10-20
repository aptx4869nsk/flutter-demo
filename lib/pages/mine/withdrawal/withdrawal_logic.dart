import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:common_utils/common_utils.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:sprintf/sprintf.dart';

enum WithdrawalType {
  usdt,
  cny,
  bsc,
}

class WithdrawalLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final amountCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final selectedWithdrawalType = WithdrawalType.usdt.obs;
  final minCnyWithdrawalAmt = 0.obs;
  final maxCnyWithdrawalAmt = 0.obs;
  final minUsdtWithdrawalAmt = 0.obs;
  final maxUsdtWithdrawalAmt = 0.obs;
  final minBscWithdrawalAmt = 0.obs;
  final maxBscWithdrawalAmt = 0.obs;
  final cnyWithdrawalTimeStart = ''.obs;
  final cnyWithdrawalTimeEnd = ''.obs;
  final usdtWithdrawalTimeStart = ''.obs;
  final usdtWithdrawalTimeEnd = ''.obs;
  final bscWithdrawalTimeStart = ''.obs;
  final bscWithdrawalTimeEnd = ''.obs;
  final withdrawalNotes = ''.obs;
  final balance = ''.obs; // 余额宝

  WithdrawalType get withdrawalType => selectedWithdrawalType.value;

  void withdrawalHistory() => AppNavigator.startUserWithdrawalHistory();

  @override
  void onInit() {
    final limitation = indexLogic.preload.value.limit?.withdraw;
    final withdrawalTime = indexLogic.preload.value.withdrawTime;
    minCnyWithdrawalAmt.value = limitation?.cnyMin ?? 0;
    maxCnyWithdrawalAmt.value = limitation?.cnyMax ?? 0;
    minUsdtWithdrawalAmt.value = limitation?.usdtMin ?? 0;
    maxUsdtWithdrawalAmt.value = limitation?.usdtMax ?? 0;
    minBscWithdrawalAmt.value = limitation?.bscMin ?? 0;
    maxBscWithdrawalAmt.value = limitation?.bscMax ?? 0;
    cnyWithdrawalTimeStart.value = withdrawalTime?.cny?.start ?? '';
    cnyWithdrawalTimeEnd.value = withdrawalTime?.cny?.end ?? '';
    usdtWithdrawalTimeStart.value = withdrawalTime?.usdt?.start ?? '';
    usdtWithdrawalTimeEnd.value = withdrawalTime?.usdt?.end ?? '';
    bscWithdrawalTimeStart.value = withdrawalTime?.bsc?.start ?? '';
    bscWithdrawalTimeEnd.value = withdrawalTime?.bsc?.end ?? '';
    withdrawalNotes.value = indexLogic.preload.value.withdrawalNote ?? '';
    balance.value = indexLogic.profile.value.canWithdrawBalance ?? '';
    super.onInit();
  }

  // USDT-RMB 转换
  void toggleWithdrawalType(WithdrawalType type) {
    // CNY
    if(type == WithdrawalType.cny) {
      if(indexLogic.profile.value.card?.status == 0) {
        AppWidget.showToast('请绑定银行卡');
        return;
      }
    }
    // USDT
    if(type == WithdrawalType.usdt) {
      if(indexLogic.profile.value.trcStatus == 0) {
        AppWidget.showToast('请绑定TRC地址');
        return;
      }
    }
    // BSC
    if(type == WithdrawalType.bsc) {
      if(indexLogic.profile.value.bscStatus == 0) {
        AppWidget.showToast('请绑定BSC地址');
        return;
      }
    }
    selectedWithdrawalType.value = type;
  }

  // 提交
  void withdrawal() {
    if (amountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterDepositAmt);
      return;
    }
    if (pwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPassword);
      return;
    }
    // validation
    final withdrawalAmt = int.parse(amountCtrl.text);
    final dateUtc = DateTime.now().toUtc();
    final localTime = dateUtc.toLocal();
    String currentDT =
        DateUtil.formatDate(localTime, format: "yyyy-MM-dd HH:mm:ss");
    var dateTime = currentDT.split(' ');
    String currentDate = dateTime[0];
    if (withdrawalType == WithdrawalType.cny) {
      if (withdrawalAmt < minCnyWithdrawalAmt.value) {
        String msg = sprintf(Globe.minWithdrawalAmt, [minCnyWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (withdrawalAmt > maxCnyWithdrawalAmt.value) {
        String msg = sprintf(Globe.maxWithdrawalAmt, [maxCnyWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = cnyWithdrawalTimeStart.value;
      String endTime = cnyWithdrawalTimeEnd.value;
      String withdrawalStartTime = "$currentDate $startTime";
      String withdrawalEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(withdrawalStartTime);
      DateTime dt1End = DateTime.parse(withdrawalEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.withdrawalTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    } else if(withdrawalType == WithdrawalType.usdt) {
      if (withdrawalAmt < minUsdtWithdrawalAmt.value) {
        String msg = sprintf(Globe.minWithdrawalAmt, [minUsdtWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (withdrawalAmt > maxUsdtWithdrawalAmt.value) {
        String msg = sprintf(Globe.maxWithdrawalAmt, [maxUsdtWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = usdtWithdrawalTimeStart.value;
      String endTime = usdtWithdrawalTimeEnd.value;
      String withdrawalStartTime = "$currentDate $startTime";
      String withdrawalEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(withdrawalStartTime);
      DateTime dt1End = DateTime.parse(withdrawalEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.withdrawalTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    } else {
      if (withdrawalAmt < minBscWithdrawalAmt.value) {
        String msg = sprintf(Globe.minWithdrawalAmt, [minBscWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (withdrawalAmt > maxBscWithdrawalAmt.value) {
        String msg = sprintf(Globe.maxWithdrawalAmt, [maxBscWithdrawalAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = bscWithdrawalTimeStart.value;
      String endTime = bscWithdrawalTimeEnd.value;
      String withdrawalStartTime = "$currentDate $startTime";
      String withdrawalEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(withdrawalStartTime);
      DateTime dt1End = DateTime.parse(withdrawalEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.withdrawalTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        var suc = await Apis.withdrawal(
          currency: withdrawalType == WithdrawalType.cny
              ? 1
              : withdrawalType == WithdrawalType.usdt
              ? 2
              : 3,
          amount: amountCtrl.text,
          password: pwdCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('withdrawal e: $e $s');
      }
    });
  }

  @override
  void onClose() {
    amountCtrl.dispose();
    pwdCtrl.dispose();
    super.onClose();
  }
}
