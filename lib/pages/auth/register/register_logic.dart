import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/pages/auth/login/login_logic.dart';

class RegisterLogic extends GetxController {
  final accountCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final invitationCodeCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final confirmPwdCtrl = TextEditingController();
  final areaCode = "+86".obs;
  final loginLogic = Get.find<LoginLogic>();

  void login() => Get.back();

  // 发送短信验证码
// Future<bool> getOtpCode() async => true;
  Future<bool> getOtpCode() async {
    if (phoneCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPhone);
      return false;
    }
    if (!AppUtils.isChinaMobile(phoneCtrl.text)) {
      AppWidget.showToast(Globe.plsEnterRightPhone);
      return false;
    }
    return Apis.getOtp(
      phone: phoneCtrl.text.trim(),
    );
  }

  void register() {
    if(loginLogic.registerSettings.value
        .canRegister ==
        0) {
      AppWidget.showToast(Globe.canNotRegister);
      return;
    }
    if (accountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterAccount);
      return;
    }
    if (phoneCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPhone);
      return;
    }
    if(!AppUtils.isChinaMobile(phoneCtrl.text)) {
      AppWidget.showToast(Globe.plsEnterRightPhone);
      return;
    }
    if(loginLogic.registerSettings.value
        .canGetOtp ==
        1) {
      if (otpCtrl.text.isEmpty) {
        AppWidget.showToast(Globe.plsEnterOtp);
        return;
      }
      // temp
      if (otpCtrl.text.length != 6) {
        AppWidget.showToast('验证码不正确');
        return;
      }
    }
    if (invitationCodeCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterInvitationCode);
      return;
    }
    if (pwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPassword);
      return;
    }
    if (confirmPwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterConfirmPassword);
      return;
    }
    if (pwdCtrl.text != confirmPwdCtrl.text) {
      AppWidget.showToast(Globe.pwdNotMatch);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final suc = await Apis.register(
          name: accountCtrl.text,
          phone: phoneCtrl.text,
          password: pwdCtrl.text,
          inviteCode: invitationCodeCtrl.text,
          otp: otpCtrl.text,
        );
        if (suc) {
          Get.back();
        }
      } catch (e, s) {
        Logger.print('register e: $e $s');
      }
    });
  }
}
