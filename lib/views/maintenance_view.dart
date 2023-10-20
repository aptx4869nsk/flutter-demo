import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';


class MaintenanceView extends StatelessWidget {
  final String? htmlData;

  const MaintenanceView({
    Key? key,
    this.htmlData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 26.w),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.verticalSpace,
              // Image.asset(
              //   ImageStr.ic_systemMaintenance,
              //   fit: BoxFit.fill,
              //   width: 180.w,
              //   height: 120.h,
              // ),
              30.verticalSpace,
              Html(
                data: htmlData ?? '',
                style: {
                  "body": Style(
                    fontSize: FontSize(16.sp),
                    textAlign: TextAlign.center,
                  ),
                },
              ),
              30.verticalSpace,
              // 退出App
              _buildButton(
                text: Globe.close,
                txtStyle: Styles.tsDefaultTxtClr16sp,
                onTap: () => exit(0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void closeApp() {
  //   // Method:1
  //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //   // Method:2
  //   exit(0);
  // }

  Widget _buildButton({
    required String text,
    Function()? onTap,
    TextStyle? txtStyle,
  }) =>
      SizedBox(
        width: double.infinity,
        height: 44.h,
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Styles.defaultBtnBgClrOpacity20,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(text, style: txtStyle),
          ),
        ),
      );
}
