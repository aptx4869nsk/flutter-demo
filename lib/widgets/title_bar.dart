import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/custom_ext.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({
    Key? key,
    this.height,
    this.left,
    this.center,
    this.right,
    this.backgroundColor,
    this.showUnderline = false,
  }) : super(key: key);
  final double? height;
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final Color? backgroundColor;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: backgroundColor ?? Styles.defaultAppBarBgClr,
        padding: EdgeInsets.only(top: mq.padding.top),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: showUnderline
              ? BoxDecoration(
                  border: BorderDirectional(
                    bottom:
                        BorderSide(color: Styles.cThemeOpacity20, width: 2.5),
                  ),
                )
              : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (null != left) Positioned(left: 0, child: left!),
              if (null != center) center!,
              if (null != right) Positioned(right: 0, child: right!),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 44.h);

  TitleBar.explore({
    super.key,
    this.showUnderline = false,
  })  : height = 44.h,
        backgroundColor = Colors.transparent,
        center = Center(
          child: Text(
            Globe.product,
            style: Styles.tsDefaultTxtClr20sp,
          ),
        ),
        left = null,
        right = null;

  TitleBar.back({
    super.key,
    String? title,
    String? leftTitle,
    TextStyle? titleStyle,
    TextStyle? leftTitleStyle,
    String? result,
    Color? backgroundColor,
    Color? backIconColor,
    this.right,
    this.showUnderline = false,
    Function()? onTap,
  })  : height = 44.h,
        backgroundColor = backgroundColor ?? Styles.defaultAppBarBgClr,
        center = Text(title ?? '',
            style: titleStyle ?? Styles.tsDefaultTxtClr17spSemiBold),
        left = GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap ?? (() => Get.back(result: result)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageStr.icBackBlack.toImage
                ..width = 24.w
                ..height = 24.h
                ..color = backIconColor,
              if (null != leftTitle)
                Text(leftTitle,
                    style:
                        leftTitleStyle ?? Styles.tsDefaultTxtClr17spSemiBold),
            ],
          ),
        );

// TitleBar.search({
//   super.key,
//   String? hintText,
//   TextEditingController? controller,
//   FocusNode? focusNode,
//   bool autofocus = true,
//   Function(String)? onSubmitted,
//   Function()? onCleared,
//   ValueChanged<String>? onChanged,
// })  : height = 44.h,
//       backgroundColor = Styles.c_FFFFFF,
//       center = Container(
//         margin: EdgeInsets.only(left: 35.w),
//         child: SearchBox(
//           enabled: true,
//           autofocus: autofocus,
//           hintText: hintText,
//           controller: controller,
//           focusNode: focusNode,
//           onSubmitted: onSubmitted,
//           onCleared: onCleared,
//           onChanged: onChanged,
//         ),
//       ),
//       showUnderline = true,
//       right = null,
//       left = ImageStr.icBackBlack.toImage
//         ..width = 24.w
//         ..height = 24.h
//         ..onTap = (() => Get.back());
}
