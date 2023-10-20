import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:sprintf/sprintf.dart';
import 'wallet_logic.dart';

class WalletPage extends StatelessWidget {
  final logic = Get.find<WalletLogic>();

  WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.balanceToPoints,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                InputBox.numberBox(
                  label: Globe.walletTransferAmt,
                  hintText: Globe.plsEnterWalletTransferAmt,
                  controller: logic.amountCtrl,
                  leadingIcon: ImageStr.icDepositAmt,
                ),
                5.verticalSpace,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    sprintf(Globe.remainingBalance, [logic.remainingBalance]),
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
                10.verticalSpace,
                InputBox.password(
                  label: Globe.password,
                  hintText: Globe.plsEnterPassword,
                  controller: logic.pwdCtrl,
                  leadingIcon: ImageStr.icPwdLock,
                ),
                45.verticalSpace,
                InkWell(
                  onTap: logic.walletToPointsSwap,
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
