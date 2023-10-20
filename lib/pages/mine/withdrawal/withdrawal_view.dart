import 'package:flutter_html/flutter_html.dart';
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
import 'package:sprintf/sprintf.dart';

import 'withdrawal_logic.dart';

class WithdrawalPage extends StatelessWidget {
  final logic = Get.find<WithdrawalLogic>();

  WithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.userWithdrawal,
          backgroundColor: Styles.defaultAppBarBgClr,
          right: Globe.history.toText
            ..style = Styles.tsDefaultTxtClr16sp
            ..onTap = logic.withdrawalHistory,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputBox.numberBox(
                    label: Globe.depositAmt,
                    hintText: Globe.plsEnterDepositAmt,
                    controller: logic.amountCtrl,
                    leadingIcon: ImageStr.icDepositAmt,
                  ),
                  5.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        sprintf(Globe.remainingBalance, [logic.balance.value]),
                        style: Styles.tsDefaultTxtClr14sp,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    Globe.depositType,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                  6.verticalSpace,
                  _depositTypeToggle(
                    toggle: logic.toggleWithdrawalType,
                    type: logic.withdrawalType,
                  ),
                  10.verticalSpace,
                  InputBox.password(
                    label: Globe.withdrawalPwd,
                    hintText: Globe.plsEnterWithdrawalPwd,
                    controller: logic.pwdCtrl,
                    leadingIcon: ImageStr.icPwdLock,
                  ),
                  45.verticalSpace,
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: logic.withdrawal,
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
                  45.verticalSpace,
                  Html(
                    data: logic.withdrawalNotes.value,
                    style: {
                      "body": Style(
                        fontSize: FontSize(14.sp),
                        color: Styles.defaultTxtClr,
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _depositTypeToggle({
  required Function toggle,
  required WithdrawalType type,
}) =>
    SizedBox(
      height: 52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(WithdrawalType.usdt),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == WithdrawalType.usdt
                      ? Styles.defaultBtnBgClr
                      : Styles.c_E2F2D1,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1), //
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ImageStr.icUsdt.toImage
                      ..width = 28.w
                      ..height = 28.h,
                    8.horizontalSpace,
                    Text(
                      Globe.usdt,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(WithdrawalType.bsc),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == WithdrawalType.bsc
                      ? Styles.defaultBtnBgClr
                      : Styles.c_E2F2D1,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1), //
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ImageStr.icBsc.toImage
                      ..width = 28.w
                      ..height = 28.h,
                    8.horizontalSpace,
                    Text(
                      Globe.bsc,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(WithdrawalType.cny),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == WithdrawalType.cny
                      ? Styles.defaultBtnBgClr
                      : Styles.c_E2F2D1,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1), //
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ImageStr.icRmb.toImage
                      ..width = 28.w
                      ..height = 28.h,
                    8.horizontalSpace,
                    Text(
                      Globe.rmb,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
