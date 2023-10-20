import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/pages/index/index_logic.dart';

enum NrcType { front, back }

enum ImageType { file, network }

// 0 未实名 1 审核中 2 已实名 3 实名失败
enum VerificationStatus { init, pending, success, failed }

class VerificationLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final realNameCtrl = TextEditingController();
  final nrcNbrCtrl = TextEditingController();
  final realName = ''.obs;
  final nrcNbr = ''.obs;
  final editRealName = true.obs;
  final editNrcNbr = true.obs;

  // images
  final frontImgFileName = ''.obs;
  final frontTempFilePath = ''.obs;
  final frontImgFile = File('').obs;
  final backImgFileName = ''.obs;
  final backTempFilePath = ''.obs;
  final backImgFile = File('').obs;
  final frontNetImg = ''.obs;
  final backNetImg = ''.obs;
  final frontImgType = ImageType.file.obs;
  final backImgType = ImageType.file.obs;

  // status
  final currentVerificationStatus = VerificationStatus.init.obs;

  // image-picker
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    final card = indexLogic.profile.value.card;
    final oss = indexLogic.preload.value.filePath ?? '';

    if (card?.status == 1) {
      currentVerificationStatus.value = VerificationStatus.pending;
      editRealName.value = false;
      editNrcNbr.value = false;
    } else if (card?.status == 2) {
      currentVerificationStatus.value = VerificationStatus.success;
      editRealName.value = false;
      editNrcNbr.value = false;
    } else if (card?.status == 3) {
      currentVerificationStatus.value = VerificationStatus.failed;
    } else {
      currentVerificationStatus.value = VerificationStatus.init;
    }
    realName.value = card?.name ?? '';
    nrcNbr.value = card?.number ?? '';
    realNameCtrl.text = realName.value;
    nrcNbrCtrl.text = nrcNbr.value;
    frontNetImg.value = card?.front ?? '';
    backNetImg.value = card?.back ?? '';
    if (frontNetImg.value.isNotEmpty) {
      frontImgType.value = ImageType.network;
      frontTempFilePath.value = oss + frontNetImg.value;
    }
    if (backNetImg.value.isNotEmpty) {
      backImgType.value = ImageType.network;
      backTempFilePath.value = oss + backNetImg.value;
    }

    // temp for test
    // realNameCtrl.text = "红红火火";
    // nrcNbrCtrl.text = "533525199911075249";

    super.onInit();
  }

  VerificationStatus get verificationStatus => currentVerificationStatus.value;

  ImageType get nrcFrontImgType => frontImgType.value;

  ImageType get nrcBackImgType => backImgType.value;

  void updateRealName() => editRealName.value = true;

  void updateNrcNbr() => editNrcNbr.value = true;

  // 获取图片
  void pickImage(NrcType type) async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      String fileName = file.name.split('image_picker').last;
      switch (type) {
        case NrcType.front:
          {
            frontImgFileName.value = fileName;
            frontTempFilePath.value = file.path;
            frontImgFile.value = File(file.path);
            frontImgType.value = ImageType.file;
          }
          break;
        case NrcType.back:
          {
            backImgFileName.value = fileName;
            backTempFilePath.value = file.path;
            backImgFile.value = File(file.path);
            backImgType.value = ImageType.file;
          }
          break;
      }
    }
  }

  void verify() {
    if (realNameCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterRealName);
      return;
    }
    if(!AppUtils.isChineseName(realNameCtrl.text)) {
      AppWidget.showToast(Globe.plsEnterValidHolderName);
      return;
    }
    if (nrcNbrCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterNrcNbr);
      return;
    }
    if (frontTempFilePath.value.isEmpty) {
      AppWidget.showToast(Globe.plsUploadNrcFront);
      return;
    }
    if (backTempFilePath.value.isEmpty) {
      AppWidget.showToast(Globe.plsUploadNrcBack);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        if (realName.value.isEmpty && nrcNbr.value.isEmpty) {
          final suc = await _nrcFormSubmit();
          if (suc) {
            if (nrcFrontImgType == ImageType.network &&
                nrcBackImgType == ImageType.network) {
              AppWidget.showToast(Globe.verificationReqSuccess);
              Get.back();
              return;
            }
            if (nrcFrontImgType == ImageType.file) {
              final nrcFrontSuc = await _uploadNrc(NrcType.front);
              if (nrcFrontSuc) {
                if (nrcBackImgType == ImageType.file) {
                  final nrcBackSuc = await _uploadNrc(NrcType.back);
                  if (nrcBackSuc) {
                    AppWidget.showToast(Globe.verificationReqSuccess);
                  } else {
                    AppWidget.showToast(Globe.nrcUploadFailed);
                  }
                }
              } else {
                AppWidget.showToast(Globe.nrcUploadFailed);
              }
            }
            // final nrcFrontSuc = await _uploadNrc(NrcType.front);
            // if (nrcFrontSuc) {
            //   final nrcBackSuc = await _uploadNrc(NrcType.back);
            //   if (nrcBackSuc) {
            //     AppWidget.showToast(Globe.verificationReqSuccess);
            //   } else {
            //     AppWidget.showToast(Globe.nrcUploadFailed);
            //   }
            // } else {
            //   AppWidget.showToast(Globe.nrcUploadFailed);
            // }
          }
        } else {
          // 只上传身份证
          final nrcFrontSuc = await _uploadNrc(NrcType.front);
          if (nrcFrontSuc) {
            final nrcBackSuc = await _uploadNrc(NrcType.back);
            if (nrcBackSuc) {
              AppWidget.showToast(Globe.verificationReqSuccess);
            } else {
              AppWidget.showToast(Globe.nrcUploadFailed);
            }
          } else {
            AppWidget.showToast(Globe.nrcUploadFailed);
          }
        }
        indexLogic.getProfile();
        Get.back();
      } catch (e, s) {
        Logger.print('verification e: $e $s');
      }
    });
  }

  Future<bool> _nrcFormSubmit() async {
    try {
      return Apis.realNameVerification(
        realName: realNameCtrl.text,
        nrcNbr: nrcNbrCtrl.text,
      );
    } catch (e, s) {
      Logger.print('verification e: $e $s');
    }
    return false;
  }

  Future<bool> _uploadNrc(NrcType type) async {
    try {
      switch (type) {
        case NrcType.front:
          return await Apis.uploadNrc(
              type: 'front', path: frontTempFilePath.value);
        case NrcType.back:
          return Apis.uploadNrc(type: 'back', path: backTempFilePath.value);
      }
    } catch (e, s) {
      Logger.print('verification e: $e $s');
    }
    return false;
  }

  @override
  void onClose() {
    realNameCtrl.dispose();
    nrcNbrCtrl.dispose();
    super.onClose();
  }
}
