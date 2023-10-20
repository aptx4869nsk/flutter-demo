import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'withdrawal_pwd_logic.dart';

class WithdrawalPwdPage extends StatelessWidget {
  final logic = Get.find<WithdrawalPwdLogic>();

  WithdrawalPwdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Obx(
        () => Scaffold(
          appBar: TitleBar.back(
            title: logic.isWithdrawalPwdSet.value
                ? Globe.modifyWithdrawalPwd
                : Globe.setWithdrawalPwd,
            backgroundColor: Styles.defaultAppBarBgClr,
          ),
          backgroundColor: Styles.defaultScaffoldBgClr,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: logic.isWithdrawalPwdSet.value
                ? Column(
                    children: [
                      InputBox.password(
                        label: Globe.newPwd,
                        hintText: Globe.plsEnterNewPwd,
                        controller: logic.newPwdCtrl,
                        leadingIcon: ImageStr.icPwdLock,
                      ),
                      10.verticalSpace,
                      InputBox.password(
                        label: Globe.confirmNewPwd,
                        hintText: Globe.plsEnterConfirmNewPwd,
                        controller: logic.confirmNewPwdCtrl,
                        leadingIcon: ImageStr.icPwdLock,
                      ),
                      10.verticalSpace,
                      InputBox.password(
                        label: Globe.oldPwd,
                        hintText: Globe.plsEnterOldPwd,
                        controller: logic.oldPwdCtrl,
                        leadingIcon: ImageStr.icPwdLock,
                      ),
                      25.verticalSpace,
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: logic.modifyWithdrawalPwd,
                        child: SizedBox(
                          height: 48.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Styles.defaultBtnBgClr,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Center(
                              child: Text(
                                Globe.confirm,
                                style: Styles.tsDefaultTxtClr14spBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      InputBox.password(
                        label: Globe.pwd,
                        hintText: Globe.plsEnterPassword,
                        controller: logic.pwdCtrl,
                        leadingIcon: ImageStr.icPwdLock,
                      ),
                      10.verticalSpace,
                      InputBox.password(
                        label: Globe.confirmPassword,
                        hintText: Globe.plsEnterConfirmPassword,
                        controller: logic.confirmPwdCtrl,
                        leadingIcon: ImageStr.icPwdLock,
                      ),
                      25.verticalSpace,
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: logic.setWithdrawalPwd,
                        child: SizedBox(
                          height: 48.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Styles.defaultBtnBgClr,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Center(
                              child: Text(
                                Globe.confirm,
                                style: Styles.tsDefaultTxtClr14spBold,
                              ),
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
