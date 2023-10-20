import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'points_transfer_logic.dart';

class PointsTransferPage extends StatelessWidget {
  final logic = Get.find<PointsTransferLogic>();

  PointsTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.pointsTransfer,
          backgroundColor: Styles.defaultAppBarBgClr,
          right: Globe.history.toText
            ..style = Styles.tsDefaultTxtClr16sp
            ..onTap = logic.transferHistory,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  InputBox.search(
                    label: Globe.transferToAcc,
                    hintText: Globe.plsEnterTransferToAcc,
                    controller: logic.transferAccCtrl,
                    leadingIcon: ImageStr.icPerson,
                    onSearch: () => logic.search,
                  ),
                  10.verticalSpace,
                  _transferAccInfo(
                    name: logic.transferAccName.value,
                  ),
                  10.verticalSpace,
                  InputBox.numberBox(
                    label: Globe.transferAmt,
                    hintText: Globe.plsEnterTransferAmt,
                    controller: logic.amountCtrl,
                    leadingIcon: ImageStr.icTransferAmt,
                  ),
                  5.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: sprintf(Globe.remainingPoints, [
                      logic.remainingPoints.value,
                    ]).toText
                      ..style = Styles.tsDefaultTxtClr14sp,
                  ),
                  InputBox.password(
                    label: Globe.withdrawalPwd,
                    hintText: Globe.plsEnterWithdrawalPwd,
                    controller: logic.pwdCtrl,
                    leadingIcon: ImageStr.icPwdLock,
                  ),
                  45.verticalSpace,
                  InkWell(
                    onTap: logic.transfer,
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
      ),
    );
  }
}

Widget _transferAccInfo({
  required String name,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Globe.transferAccName,
          style: Styles.tsDefaultTxtClr14sp,
        ),
        6.verticalSpace,
        Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            color: Styles.c_E2F2D1,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              15.horizontalSpace,
              ImageStr.icPerson.toImage
                ..width = 28.w
                ..height = 28.h,
              10.horizontalSpace,
              name.isEmpty
                  ? Expanded(
                      child: Text(
                        Globe.transferAccName,
                        style: Styles.ts_8E9AB0_14sp,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        name,
                        style: Styles.tsDefaultTxtClr16sp,
                      ),
                    ),
            ],
          ),
        )
      ],
    );
