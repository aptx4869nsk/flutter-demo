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
import 'package:kaibo/views/input_box_view.dart';

import 'billing_address_logic.dart';

class BillingAddressPage extends StatelessWidget {
  final logic = Get.find<BillingAddressLogic>();

  BillingAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.modifyShippingAddr,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                logic.editPhone.value
                    ? InputBox.numberBox(
                        label: Globe.shippingPhone,
                        hintText: Globe.plsEnterShippingPhone,
                        controller: logic.phoneCtrl,
                        leadingIcon: ImageStr.icPhone,
                      )
                    : InputBoxView(
                        label: Globe.shippingPhone,
                        text: logic.phone.value,
                        leadingIcon: ImageStr.icPhone,
                        trailingTxt: Globe.edit,
                        onClick: logic.updateShippingPhone,
                      ),
                10.verticalSpace,
                logic.editShippingAddr.value
                    ? InputBox.textBox(
                        label: Globe.shippingAddr,
                        hintText: Globe.plsEnterShippingAddr,
                        controller: logic.shippingAddrCtrl,
                        leadingIcon: ImageStr.icBillingAddr,
                      )
                    : InputBoxView(
                        label: Globe.shippingAddr,
                        text: logic.shippingAddr.value,
                        leadingIcon: ImageStr.icBillingAddr,
                        trailingTxt: Globe.edit,
                        onClick: logic.updateShippingAddr,
                      ),
                25.verticalSpace,
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: logic.modifyShippingAddr,
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
      ),
    );
  }
}
