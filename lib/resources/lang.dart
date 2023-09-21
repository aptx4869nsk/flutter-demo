import 'dart:ui';

import 'package:get/get.dart';

import 'package:mini_store/lang/en_us.dart';
import 'package:mini_store/lang/zh_cn.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'zh_CN': zhCN,
      };
}

class Globe {
  Globe._();

  // splash
  static String get welcome => 'welcome'.tr;
  // bottom-nav-bar
  static String get home => 'home'.tr;
  static String get mine => 'mine'.tr;
  // toast
  static String get copySuccessfully => 'copySuccessfully'.tr;
  // update manager
  static String get downloading => 'downloading'.tr;
  static String get downloadFailed => 'downloadFailed'.tr;
  // upgrade view
  static String get upgradeFind => 'upgradeFind'.tr;
  static String get upgradeVersion => 'upgradeVersion'.tr;
  static String get upgradeDescription => 'upgradeDescription'.tr;
  static String get upgradeIgnore => 'upgradeIgnore'.tr;
  static String get upgradeLater => 'upgradeLater'.tr;
  static String get upgradeNow => 'upgradeNow'.tr;
}
