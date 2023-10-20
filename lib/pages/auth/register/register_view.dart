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

import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.find<RegisterLogic>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TouchCloseSoftKeyboard(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Stack(
            children: [
              _registerHeader(context),
              Positioned.fill(
                top: 110.h,
                child: SingleChildScrollView(
                  child: Container(
                    height: 1.sh - 240.h + 110.h + 20.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Styles.c_FFFFFF,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Text(
                          Globe.register,
                          style: Styles.tsDefaultTxtClr18spSemiBold,
                          textAlign: TextAlign.center,
                        ),
                        45.verticalSpace,
                        InputBox.textBox(
                          label: Globe.nickName,
                          controller: logic.accountCtrl,
                          hintText: Globe.plsEnterNickName,
                          leadingIcon: ImageStr.icPerson,
                          backgroundColor: Styles.c_FFFFFF,
                        ),
                        15.verticalSpace,
                        InputBox.phone(
                          code: logic.areaCode.value,
                          label: Globe.phone,
                          controller: logic.phoneCtrl,
                          hintText: Globe.plsEnterPhone,
                          leadingIcon: ImageStr.icPhone,
                          backgroundColor: Styles.c_FFFFFF,
                        ),
                        Visibility(
                          visible: logic.loginLogic.registerSettings.value
                                  .canGetOtp ==
                              1,
                          child: Column(
                            children: [
                              15.verticalSpace,
                              InputBox.verificationCode(
                                label: Globe.verificationCode,
                                controller: logic.otpCtrl,
                                hintText: Globe.plsEnterOtp,
                                leadingIcon: ImageStr.icOtp,
                                backgroundColor: Styles.c_FFFFFF,
                                onSendVerificationCode: logic.getOtpCode,
                              ),
                            ],
                          ),
                        ),
                        15.verticalSpace,
                        InputBox.textBox(
                          label: Globe.invitationCode,
                          controller: logic.invitationCodeCtrl,
                          hintText: Globe.plsEnterInvitationCode,
                          leadingIcon: ImageStr.icInvitationCode,
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
                        InputBox.password(
                          label: Globe.confirmPassword,
                          controller: logic.confirmPwdCtrl,
                          hintText: Globe.plsEnterConfirmPassword,
                          leadingIcon: ImageStr.icPwdLock,
                          backgroundColor: Styles.c_FFFFFF,
                        ),
                        45.verticalSpace,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: logic.register,
                          child: SizedBox(
                            height: 48.h,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Styles.defaultBtnBgClr,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Center(
                                child: Text(
                                  Globe.register,
                                  style: Styles.tsDefaultTxtClr14spBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 140.h,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                style: Styles.tsDefaultTxtClr14sp,
                                children: <TextSpan>[
                                  TextSpan(text: Globe.alreadyHaveAcc),
                                  TextSpan(
                                    text: Globe.login,
                                    style: Styles.tsTheme12sp,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = logic.login,
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
            ],
          ),
        ),
      ),
    );
  }
}

Widget _registerHeader(context) => Positioned(
      child: Container(
        width: double.infinity,
        height: 240.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageStr.icLoginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.back(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageStr.icBackBlack.toImage
                          ..width = 24.w
                          ..height = 24.h
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
