import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/utils/logger.dart';

class InvitationLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final appLogic = Get.find<AppController>();
  final androidApkDownloadLink = ''.obs;
  final invitationCode = ''.obs;


  @override
  void onInit() {
    androidApkDownloadLink.value = appLogic.upgradeInfo?.apkDownloadLink ?? "";
    invitationCode.value = indexLogic.profile.value.inviteCode ?? "";
    super.onInit();
  }

  String buildQRContent() {
    return androidApkDownloadLink.value;
  }

  void saveToGallery(GlobalKey key) async {
    await AppUtils.captureWidgetToGallery(key);
  }
  
  void copy() {
    Logger.print("copy  >>>>>>>>>> ${androidApkDownloadLink.value}");
    AppUtils.copy(text: androidApkDownloadLink.value);
  }
}