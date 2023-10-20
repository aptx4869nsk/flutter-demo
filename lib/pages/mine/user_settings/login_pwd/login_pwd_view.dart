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

import 'login_pwd_logic.dart';

class LoginPwdPage extends StatelessWidget {
  final logic = Get.find<LoginPwdLogic>();

  LoginPwdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.modifyLoginPwd,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
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
                onTap: logic.modifyLoginPwd,
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
    );
  }
}
