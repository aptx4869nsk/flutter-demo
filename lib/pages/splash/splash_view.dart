import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final logic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<SplashLogic>(
        init: SplashLogic(),
        builder: (logic) {
          return Stack(
            children: [
              Positioned(
                top: 580.h, // 603
                width: 375.w,
                child: Center(
                  child: Image.asset(
                    ImageStr.icApp,
                    width: 85.w,
                    height: 85.h,
                  ),
                ),
              ),
              Positioned(
                top: 673.h,
                width: 375.w,
                child: Center(
                  child: Text(
                    Globe.welcome,
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Styles.theme,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
