import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/logger.dart';

class ModifyPhoneLogic extends GetxController {
  final areaCode = "+86".obs;
  final phoneCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  void modifyPhone() {
    Logger.print('clicked modify phone');
  }

  @override
  void onClose() {
    phoneCtrl.dispose();
    pwdCtrl.dispose();
    super.onClose();
  }
}
