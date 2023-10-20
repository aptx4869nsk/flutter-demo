import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  Styles._();

  static Color theme = c_6f9122;
  static Color defaultTxtClr = c_0C1C33;
  static Color secondaryTxtClr = c_858585;
  static Color defaultScaffoldBgClr = c_D6E7C9;
  static Color defaultAppBarBgClr = c_A1CA27;
  static Color defaultShadowClr = c_C4C4C4;
  static Color defaultDividerClr = c_333333;
  static Color defaultBtnBgClr = c_A1CA27;
  static Color pendingClr = c_A9AC09;
  static Color successClr = c_03810F;
  static Color failedClr = c_ED3209;
  static Color pendingBtnBgClr = cDBD438Opacity20;
  static Color successBtnBgClr = c1CB619Opacity20;
  static Color failedBtnBgClr = cED3209Opacity20;
  static Color profitTxtClr = c_A1CA27;
  static Color lostTxtClr = c_CA2727;
  static Color shimmerBaseColor = defaultBtnBgClr.withOpacity(.2);
  static Color shimmerHighLightColor = defaultBtnBgClr.withOpacity(.4);


  static Color c_333333 = const Color(0xFF333333);
  static Color c_6f9122 = const Color(0xFF6F9122);

  // app_widget
  static Color c_DA1F13 = const Color(0xFFDA1F13);

  // bottom_bar
  static Color c_FFFFFF = const Color(0xFFFFFFFF);
  static Color c_C4C4C4 = const Color(0xFFC4C4C4);
  static Color c_D9D9D9 = const Color(0xFFD9D9D9);

  // badge_view
  static Color c_FF381F = const Color(0xFFFF381F);

  static Color c_0C1C33 = const Color(0xFF0C1C33); // 黑色字体
  static Color c_A1CA27 = const Color(0xFFA1CA27); // 默认AppBar
  static Color c_D6E7C9 = const Color(0xFFD6E7C9); // 默认背景
  static Color c_8E9AB0 = const Color(0xFF8E9AB0); // 说明文字 - PLACEHOLDER
  static Color c_EAFAD6 = const Color(0xFFEAFAD6); // Secondary 背景
  static Color c_A9AC09 = const Color(0xFFA9AC09); // 状态 - 审核中 - 边框/字体
  static Color c_DBD438 = const Color(0xFFDBD438); // 状态 - 审核中 - 背景
  static Color c_03810F = const Color(0xFF03810F); // 状态 - 成功 - 边框/字体
  static Color c_1CB619 = const Color(0xFF1CB619); // 状态 - 成功 - 背景
  static Color c_ED3209 = const Color(0xFFED3209); // 状态 - 失败 - 边框/字体/背景
  static Color c_858585 = const Color(0xFF858585); // 灰色字体 - Secondary
  static Color c_CA2727 = const Color(0xFFCA2727); // 转出
  static Color c_f7f7f7 = const Color(0xFFF7F7F7); // network image

  // custom-dialog
  static Color c_E8EAEF = const Color(0xFFE8EAEF); // 分割线

  // mine
  static Color c_C6E37E = const Color(0xFFC6E37E);
  static Color c_E2F2D1 = const Color(0xFFE2F2D1);
  static Color c_B8B8B8 = const Color(0xFFB8B8B8);
  static Color c_A8A8A8 = const Color(0xFFA8A8A8);
  static Color c_47B972 = const Color(0xFF47B972);

  // Color with Opacity
  static Color cThemeOpacity20 = theme.withOpacity(.2);
  static Color cThemeOpacity40 = theme.withOpacity(.4);
  static Color cThemeOpacity60 = theme.withOpacity(.6);
  static Color cDividerOpacity60 = defaultDividerClr.withOpacity(.4);
  static Color cDefaultTxtClrOpacity20 = defaultTxtClr.withOpacity(.2);
  static Color cDBD438Opacity20 = c_DBD438.withOpacity(.2);
  static Color c1CB619Opacity20 = c_1CB619.withOpacity(.2);
  static Color cED3209Opacity20 = c_ED3209.withOpacity(.2);
  static Color cA8A8A8Opacity30 = c_A8A8A8.withOpacity(.3);
  static Color defaultBtnBgClrOpacity20 = defaultBtnBgClr.withOpacity(.2);
  static Color defaultTxtClrOpacity20 = defaultTxtClr.withOpacity(.2);

  // Default Text Styles
  static TextStyle tsDefaultTxtClr8sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 8.sp,
  );
  static TextStyle tsDefaultTxtClr10sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 10.sp,
  );
  static TextStyle tsDefaultTxtClr12sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 12.sp,
  );
  static TextStyle tsDefaultTxtClr12spBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold
  );
  static TextStyle tsDefaultTxtClr14sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 14.sp,
  );
  static TextStyle tsDefaultTxtClr14spBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle tsDefaultTxtClr14spSemiBoldOverflowEllipsis= TextStyle(
    color: defaultTxtClr,
    fontSize: 14.sp,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w500,
  );
  static TextStyle tsDefaultTxtClrOpacity2014spBold = TextStyle(
    color: defaultTxtClrOpacity20,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle tsDefaultTxtClr16sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 16.sp,
  );
  static TextStyle tsDefaultTxtClr16spBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle tsDefaultTxtClr17sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 17.sp,
  );
  static TextStyle tsDefaultTxtClr17spSemiBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  ); // title-bar title
  static TextStyle tsDefaultTxtClr18spSemiBold= TextStyle(
    color: defaultTxtClr,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle tsDefaultTxtClr18spBold200 = TextStyle(
    color: defaultTxtClr,
    fontSize: 18.sp,
    fontWeight: FontWeight.w200,
  );
  static TextStyle tsDefaultTxtClr18spSemiBoldLetterSpacing3sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 3.sp,
  );
  static TextStyle tsDefaultTxtClr20sp = TextStyle(
    color: defaultTxtClr,
    fontSize: 20.sp,
  );
  static TextStyle tsDefaultTxtClr20spSemiBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle tsDefaultTxtClr20spBold = TextStyle(
    color: defaultTxtClr,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle tsSecondaryTxtClr12sp = TextStyle(
    color: secondaryTxtClr,
    fontSize: 12.sp,
  );
  static TextStyle tsSecondaryTxtClr14sp = TextStyle(
    color: secondaryTxtClr,
    fontSize: 14.sp,
  );
  static TextStyle tsSecondaryTxtClr16sp = TextStyle(
    color: secondaryTxtClr,
    fontSize: 16.sp,
  );

  // Theme Text Styles
  static TextStyle ts_theme_10sp_semibold = TextStyle(
    color: theme,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  ); // bottom-bar
  static TextStyle tsTheme12sp = TextStyle(
    color: theme,
    fontSize: 14.sp,
  );
  static TextStyle tsTheme12spBold = TextStyle(
    color: theme,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold
  );
  static TextStyle ts_theme_17sp = TextStyle(
    color: theme,
    fontSize: 17.sp,
  ); //
  static TextStyle tsTheme18spBold200 = TextStyle(
    color: theme,
    fontSize: 18.sp,
    fontWeight: FontWeight.w200,
  ); // custom-dialog
  static TextStyle ts_8E9AB0_12sp = TextStyle(
    color: c_8E9AB0,
    fontSize: 12.sp,
  ); // input-box-placeholder
  static TextStyle ts_8E9AB0_17sp = TextStyle(
    color: c_8E9AB0,
    fontSize: 17.sp,
  ); // input-box-placeholder
  static TextStyle ts_8E9AB0_14sp = TextStyle(
    color: c_8E9AB0,
    fontSize: 14.sp,
  ); // input-box-placeholder

  // upgrade_view
  static TextStyle ts_FFFFFF_10sp = TextStyle(
    color: c_FFFFFF,
    fontSize: 10.sp,
  );
  static TextStyle tsFFFFFF14spBold = TextStyle(
    color: c_FFFFFF,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle tsFFFFFF16spSemiBold = TextStyle(
    color: c_FFFFFF,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // title-bar
  static TextStyle ts_0C1C33_17sp_semibold = TextStyle(
    color: c_0C1C33,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle ts_0C1C33_14sp = TextStyle(
    color: c_0C1C33,
    fontSize: 14.sp,
  );
  static TextStyle ts_0C1C33_20sp = TextStyle(
    color: c_0C1C33,
    fontSize: 20.sp,
  );

  // custom-dialog
  static TextStyle ts_0C1C33_17sp = TextStyle(
    color: c_0C1C33,
    fontSize: 17.sp,
  );

  // invitation
  static TextStyle tsB8B8B814sp = TextStyle(
    color: c_B8B8B8,
    fontSize: 14.sp,
  );

  // deposit-history
  static TextStyle tsPendingTxtClr16sp = TextStyle(
    color: pendingClr,
    fontSize: 16.sp,
  );
  static TextStyle tsSuccessTxtClr16sp = TextStyle(
    color: successClr,
    fontSize: 16.sp,
  );
  static TextStyle tsFailedTxtClr16sp = TextStyle(
    color: failedClr,
    fontSize: 16.sp,
  );


}
