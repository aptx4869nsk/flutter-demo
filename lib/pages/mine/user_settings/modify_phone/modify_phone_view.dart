import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';

import 'modify_phone_logic.dart';

class ModifyPhonePage extends StatelessWidget {
  final logic = Get.find<ModifyPhoneLogic>();

  ModifyPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.modifyPhone,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              InputBox.phone(
                label: Globe.phoneNumber,
                hintText: Globe.plsEnterPhoneNumber,
                controller: logic.phoneCtrl,
                code: logic.areaCode.value,
                leadingIcon: ImageStr.icPhone,
              ),
              10.verticalSpace,
              InputBox.password(
                label: Globe.withdrawalPwd,
                hintText: Globe.plsEnterWithdrawalPwd,
                controller: logic.pwdCtrl,
                leadingIcon: ImageStr.icPwdLock,
              ),
              25.verticalSpace,
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: logic.modifyPhone,
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
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
