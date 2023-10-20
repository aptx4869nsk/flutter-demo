import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => TouchCloseSoftKeyboard(
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Stack(
              children: [
                _loginHeader,
                Positioned.fill(
                  top: 190.h,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 1.sh - 190.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 60.h,
                      ),
                      decoration: BoxDecoration(
                        color: Styles.c_FFFFFF,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            Globe.login,
                            style: Styles.tsDefaultTxtClr18spSemiBold,
                          ),
                          45.verticalSpace,
                          InputBox.textBox(
                            label: Globe.account,
                            controller: logic.accountCtrl,
                            hintText: Globe.plsEnterAccount,
                            leadingIcon: ImageStr.icPerson,
                            backgroundColor: Styles.c_FFFFFF,
                          ),
                          15.verticalSpace,
                          InputBox.password(
                            label: Globe.pwd,
                            controller: logic.pwdCtrl,
                            hintText: Globe.plsEnterPassword,
                            leadingIcon: ImageStr.icPwdLock,
                            backgroundColor: Styles.c_FFFFFF,
                          ),
                          15.verticalSpace,
                          InputBox.recaptcha(
                            label: Globe.recaptcha,
                            controller: logic.recaptchaCtrl,
                            hintText: Globe.plsEnterRecaptcha,
                            leadingIcon: ImageStr.icOtp,
                            backgroundColor: Styles.c_FFFFFF,
                            recaptcha: logic.recaptcha.value,
                            onRecaptcha: () => logic.getRecaptcha,
                          ),
                          45.verticalSpace,
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: logic.login,
                            child: SizedBox(
                              height: 48.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Styles.defaultBtnBgClr,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                    child: Text(
                                  Globe.login,
                                  style: Styles.tsDefaultTxtClr14spBold,
                                )),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                              text: TextSpan(
                                style: Styles.tsDefaultTxtClr14sp,
                                children: <TextSpan>[
                                  TextSpan(text: Globe.haveNoAcc),
                                  TextSpan(
                                    text: Globe.register,
                                    style: Styles.tsTheme12sp,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = logic.register,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget get _loginHeader => Positioned(
      child: Container(
        width: double.infinity,
        height: 240.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageStr.icLoginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            65.verticalSpace,
            Container(
              width: 75.w,
              height: 75.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(37.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37.r),
                child: ImageStr.icApp.toImage
                  ..width = 75.w
                  ..height = 75.h
                  ..fit = BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
