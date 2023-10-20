import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:common_utils/common_utils.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/models/deposit.dart';

enum DepositType {
  usdt,
  bsc,
  cny,
}

class DepositLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final amountCtrl = TextEditingController();
  final selectedDepositType = DepositType.usdt.obs;
  final paidScreenshotFileName = ''.obs;
  final tempFilePath = ''.obs;
  final imageFile = File('').obs;
  final picker = ImagePicker();
  final minCnyDepositAmt = 0.obs;
  final maxCnyDepositAmt = 0.obs;
  final minUsdtDepositAmt = 0.obs;
  final maxUsdtDepositAmt = 0.obs;
  final minBscDepositAmt = 0.obs;
  final maxBscDepositAmt = 0.obs;
  final cnyDepositTimeStart = ''.obs;
  final cnyDepositTimeEnd = ''.obs;
  final usdtDepositTimeStart = ''.obs;
  final usdtDepositTimeEnd = ''.obs;
  final bscDepositTimeStart = ''.obs;
  final bscDepositTimeEnd = ''.obs;
  final depositAddr = DepositAddress().obs; // 充值
  final enableDepositShimmer = true.obs;

  DepositType get depositType => selectedDepositType.value;

  void depositHistory() => AppNavigator.startUserDepositHistory();

  @override
  void onInit() {
    final limitation = indexLogic.preload.value.limit?.deposit;
    final depositTime = indexLogic.preload.value.depositTime;
    minCnyDepositAmt.value = limitation?.cnyMin ?? 0;
    maxCnyDepositAmt.value = limitation?.cnyMax ?? 0;
    minUsdtDepositAmt.value = limitation?.usdtMin ?? 0;
    maxUsdtDepositAmt.value = limitation?.usdtMax ?? 0;
    minBscDepositAmt.value = limitation?.bscMin ?? 0;
    maxBscDepositAmt.value = limitation?.bscMax ?? 0;
    cnyDepositTimeStart.value = depositTime?.cny?.start ?? '';
    cnyDepositTimeEnd.value = depositTime?.cny?.end ?? '';
    usdtDepositTimeStart.value = depositTime?.usdt?.start ?? '';
    usdtDepositTimeEnd.value = depositTime?.usdt?.end ?? '';
    bscDepositTimeStart.value = depositTime?.bsc?.start ?? '';
    bscDepositTimeEnd.value = depositTime?.bsc?.end ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    getDepositAddress();
    super.onReady();
  }

  // 获取充值地址
  void getDepositAddress() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        DepositAddress data = await Apis.depositAddress();
        depositAddr.value = data;
        enableDepositShimmer.value = false;
      } catch (e, s) {
        Logger.print('deposit e: $e $s');
      }
    });
  }

  // USDT-RMB 转换
  void toggleDepositType(DepositType type) {
    selectedDepositType.value = type;
  }

  // 复制文本
  void copy(String value) {
    AppUtils.copy(text: value);
  }

  // 获取图片
  void pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      String fileName = file.name.split('image_picker').last;
      paidScreenshotFileName.value = fileName;
      tempFilePath.value = file.path;
      imageFile.value = File(file.path);
    }
  }

  // 提交
  void deposit() {
    if (amountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterDepositAmt);
      return;
    }
    if (tempFilePath.isEmpty) {
      AppWidget.showToast(Globe.plsUploadPaidScreenshot);
      return;
    }
    // validation
    final depositAmt = int.parse(amountCtrl.text);
    final dateUtc = DateTime.now().toUtc();
    final localTime = dateUtc.toLocal();
    String currentDT =
        DateUtil.formatDate(localTime, format: "yyyy-MM-dd HH:mm:ss");
    var dateTime = currentDT.split(' ');
    String currentDate = dateTime[0];
    if (depositType == DepositType.cny) {
      if (depositAmt < minCnyDepositAmt.value) {
        String msg = sprintf(Globe.minDepositAmt, [minCnyDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (depositAmt > maxCnyDepositAmt.value) {
        String msg = sprintf(Globe.maxDepositAmt, [maxCnyDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = cnyDepositTimeStart.value;
      String endTime = cnyDepositTimeEnd.value;
      String depositStartTime = "$currentDate $startTime";
      String depositEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(depositStartTime);
      DateTime dt1End = DateTime.parse(depositEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.depositTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    } else if(depositType == DepositType.usdt){
      if (depositAmt < minUsdtDepositAmt.value) {
        String msg = sprintf(Globe.minDepositAmt, [minUsdtDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (depositAmt > maxUsdtDepositAmt.value) {
        String msg = sprintf(Globe.maxDepositAmt, [maxUsdtDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = usdtDepositTimeStart.value;
      String endTime = usdtDepositTimeEnd.value;
      String depositStartTime = "$currentDate $startTime";
      String depositEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(depositStartTime);
      DateTime dt1End = DateTime.parse(depositEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.depositTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    } else {
      if (depositAmt < minBscDepositAmt.value) {
        String msg = sprintf(Globe.minDepositAmt, [minBscDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      if (depositAmt > maxBscDepositAmt.value) {
        String msg = sprintf(Globe.maxDepositAmt, [maxBscDepositAmt.value]);
        AppWidget.showToast(msg);
        return;
      }
      String startTime = usdtDepositTimeStart.value;
      String endTime = usdtDepositTimeEnd.value;
      String depositStartTime = "$currentDate $startTime";
      String depositEndTime = "$currentDate $endTime";
      DateTime dt1Start = DateTime.parse(depositStartTime);
      DateTime dt1End = DateTime.parse(depositEndTime);
      DateTime dt2 = DateTime.parse(currentDT);
      // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
      if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
        String msg = sprintf(Globe.depositTime, [startTime, endTime]);
        AppWidget.showToast(msg);
        return;
      }
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      final transactionId = await _depositFormSubmit();
      if (transactionId.isNotEmpty) {
        _uploadPaidScreenshot(transactionId);
      }
    });
  }

  // 提交充值订单
  Future<String> _depositFormSubmit() async {
    try {
      return await Apis.deposit(
        currency: depositType == DepositType.cny
            ? 1
            : depositType == DepositType.usdt
                ? 2
                : 3,
        amount: amountCtrl.text,
      );
    } catch (e, s) {
      Logger.print('deposit e: $e $s');
    }
    return '';
  }

  // 上传付款凭据
  void _uploadPaidScreenshot(String transactionId) async {
    try {
      var suc = await Apis.uploadPaidScreenshot(
        transactionId: transactionId,
        path: tempFilePath.value,
      );
      if (suc) {
        AppWidget.showToast(Globe.reqSuccess);
        amountCtrl.text = "";
        tempFilePath.value = "";
        imageFile.value = File('');
        paidScreenshotFileName.value = '';
        indexLogic.getProfile();
        Get.back();
      }
    } catch (e, s) {
      Logger.print('deposit e: $e $s');
    }
  }

  @override
  void onClose() {
    amountCtrl.dispose();
    super.onClose();
  }
}
