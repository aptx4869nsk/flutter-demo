import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:mini_store/routes/app_navigator.dart';
import 'package:mini_store/utils/data_sp.dart';

class SplashLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  String? get token => DataSp.userToken;

  @override
  void onInit() {
    animationInitialization();
    super.onInit();
  }

  animationInitialization() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 100));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        var loginCertificate = DataSp.getLoginCertificate();
        if (loginCertificate != null && loginCertificate.token.isNotEmpty) {
          AppNavigator.startMain();
        } else {
          AppNavigator.startLogin();
        }
      }
    });
    animationController.forward();
  }
}
