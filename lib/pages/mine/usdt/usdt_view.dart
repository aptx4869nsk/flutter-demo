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

import 'usdt_logic.dart';

class UsdtPage extends StatelessWidget {
  final logic = Get.find<UsdtLogic>();

  UsdtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.myUsdt,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  logic.editTrcAddr.value
                      ? InputBox.textBox(
                          label: Globe.usdtAddr,
                          hintText: Globe.plsEnterUsdtAddr,
                          controller: logic.usdtAddressCtrl,
                          leadingIcon: ImageStr.icUsdt,
                        )
                      : InputBoxView(
                          label: Globe.usdtAddr,
                          text: logic.trcAddr.value,
                          leadingIcon: ImageStr.icUsdt,
                          // trailingTxt: Globe.edit,
                          // onClick: logic.updateTrcAddr,
                        ),
                  10.verticalSpace,
                  logic.editBscAddr.value
                      ? InputBox.textBox(
                          label: Globe.bscAddr,
                          hintText: Globe.plsEnterBscAddr,
                          controller: logic.bscAddressCtrl,
                          leadingIcon: ImageStr.icBsc,
                        )
                      : InputBoxView(
                          label: Globe.bscAddr,
                          text: logic.bscAddr.value,
                          leadingIcon: ImageStr.icBsc,
                          // trailingTxt: Globe.edit,
                          // onClick: logic.updateBscAddr,
                        ),
                  45.verticalSpace,
                  Visibility(
                    visible: logic.bindUsdtBtn.value,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: logic.bind,
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
