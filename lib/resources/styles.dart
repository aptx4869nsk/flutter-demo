import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  Styles._();

  static Color theme = c_6f9122;
  static Color defaultTxtClr = theme;

  static Color c_3674fa = const Color(0xFF3674fa);
  static Color c_333333 = const Color(0xFF333333);
  static Color c_6f9122 = const Color(0xFF6F9122);
  // app_widget
  static Color c_DA1F13 = const Color(0xFFDA1F13);
  // bottom_bar
  static Color c_FFFFFF = const Color(0xFFFFFFFF);
  static Color c_E8EAEF = const Color(0xFFE8EAEF);
  static Color c_0089FF = const Color(0xFF0089FF);
  static Color c_8E9AB0 = const Color(0xFF8E9AB0);
  // badge_view
  static Color c_FF381F = const Color(0xFFFF381F);



  // bottom_bar
  static TextStyle ts_theme_10sp_semibold = TextStyle(
    color: theme,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle ts_0089FF_10sp_semibold = TextStyle(
    color: c_0089FF,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle ts_8E9AB0_10sp_semibold = TextStyle(
    color: c_8E9AB0,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );
  // upgrade_view
  static TextStyle ts_FFFFFF_10sp = TextStyle(
    color: c_FFFFFF,
    fontSize: 10.sp,
  );
}