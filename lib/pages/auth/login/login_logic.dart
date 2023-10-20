import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/models/register_settings.dart';

class LoginLogic extends GetxController {
  final accountCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final recaptchaCtrl = TextEditingController();
  final recaptcha = ''.obs;
  final appLogic = Get.find<AppController>();
  final registerSettings = RegisterSettings().obs;

  @override
  void onReady() {
    // temp for test -- start
    // accountCtrl.text = "13170693248";
    // pwdCtrl.text = "111111";
    // temp fro test --- end
    getRecaptcha();
    super.onReady();
  }

  // void register() => AppNavigator.startRegister();

  void register() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        RegisterSettings data = await Apis.getRegisterSettings();
        registerSettings.value = data;
        if(registerSettings.value.canRegister == 1) {
          AppNavigator.startRegister();
        } else {
          AppWidget.showToast(Globe.canNotRegister);
        }
      } catch (e, s) {
        Logger.print('login -> register settings e: $e $s');
      }
    });
  }

  void getRecaptcha() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        String code = await Apis.getRecaptcha();
        if (code.isNotEmpty) {
          recaptcha.value = code;
        }
      } catch (e, s) {
        Logger.print('login e: $e $s');
      }
    });
  }

  void getRegisterSettings() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        RegisterSettings data = await Apis.getRegisterSettings();
        registerSettings.value = data;
      } catch (e, s) {
        Logger.print('login -> register settings e: $e $s');
      }
    });
  }

  void login() {
    if(accountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterAccount);
      return;
    }
    if(pwdCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterPassword);
      return;
    }
    if(recaptchaCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterRecaptcha);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final data = await Apis.login(
          phone: accountCtrl.text,
          password: pwdCtrl.text,
          recaptcha: recaptchaCtrl.text,
        );
        await DataSp.putLoginCertificate(data);
        Logger.print('token: ${data.token}');
        AppNavigator.startMain();
      } catch (e, s) {
        getRecaptcha();
        recaptchaCtrl.text = '';
        Logger.print('login e: $e $s');
      }
    });
  }
}
