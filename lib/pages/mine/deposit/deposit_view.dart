import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/shimmer/deposit_shimmer.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaibo/models/deposit.dart';
import 'deposit_logic.dart';

class DepositPage extends StatelessWidget {
  final logic = Get.find<DepositLogic>();

  DepositPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => logic.enableDepositShimmer.value
          ? const DepositShimmer()
          : TouchCloseSoftKeyboard(
              child: Scaffold(
                appBar: TitleBar.back(
                  title: Globe.userDeposit,
                  backgroundColor: Styles.defaultAppBarBgClr,
                  right: Globe.history.toText
                    ..style = Styles.tsDefaultTxtClr16sp
                    ..onTap = logic.depositHistory,
                ),
                backgroundColor: Styles.defaultScaffoldBgClr,
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputBox.numberBox(
                          label: Globe.depositAmt,
                          hintText: Globe.plsEnterDepositAmt,
                          controller: logic.amountCtrl,
                          leadingIcon: ImageStr.icDepositAmt,
                        ),
                        10.verticalSpace,
                        Text(
                          Globe.depositType,
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        6.verticalSpace,
                        _depositTypeToggle(
                          toggle: logic.toggleDepositType,
                          type: logic.depositType,
                        ),
                        20.verticalSpace,
                        logic.depositType == DepositType.usdt
                            ? _usdtInfo(
                                address: logic.depositAddr.value.usdt,
                                copyAddress: logic.copy,
                              )
                            : logic.depositType == DepositType.bsc
                                ? _bscInfo(
                                    address: logic.depositAddr.value.bsc,
                                    copyAddress: logic.copy,
                                  )
                                : _bankCardInfo(
                                    bank: logic.depositAddr.value.bank,
                                    copyAccountNbr: logic.copy,
                                  ),
                        20.verticalSpace,
                        Text(
                          Globe.paidScreenshot,
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        10.verticalSpace,
                        SizedBox(
                          width: double.infinity,
                          height: 190.h,
                          child: InkWell(
                            onTap: () => logic.pickImage(),
                            child: logic.tempFilePath.value.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    child: Image.file(
                                      logic.imageFile.value,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            ImageStr.icPaidScreenshot),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.r),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        45.verticalSpace,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: logic.deposit,
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
                          data: logic.depositAddr.value.depositNote ?? '',
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
  required DepositType type,
}) =>
    SizedBox(
      height: 52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(DepositType.usdt),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == DepositType.usdt
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
              onTap: () => toggle.call(DepositType.bsc),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == DepositType.bsc
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
              onTap: () => toggle.call(DepositType.cny),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Styles.c_E2F2D1, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  color: type == DepositType.cny
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

Widget _usdtInfo({
  required String? address,
  required Function copyAddress,
}) =>
    Visibility(
      visible: AppUtils.isNotNullEmptyStr(address),
      child: Container(
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
            ImageStr.icUsdt.toImage
              ..width = 28.w
              ..height = 28.h,
            10.horizontalSpace,
            Expanded(
              child: Text(
                address ?? '',
                style: Styles.tsDefaultTxtClr16sp,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () => copyAddress.call(address),
              child: Container(
                width: 70.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Styles.defaultBtnBgClr,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
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
                child: Center(
                  child: Text(
                    Globe.copy,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget _bscInfo({
  required String? address,
  required Function copyAddress,
}) =>
    Visibility(
      visible: AppUtils.isNotNullEmptyStr(address),
      child: Container(
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
            ImageStr.icBsc.toImage
              ..width = 28.w
              ..height = 28.h,
            10.horizontalSpace,
            Expanded(
              child: Text(
                address ?? '',
                style: Styles.tsDefaultTxtClr16sp,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () => copyAddress.call(address),
              child: Container(
                width: 70.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Styles.defaultBtnBgClr,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
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
                child: Center(
                  child: Text(
                    Globe.copy,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget _bankCardInfo({
  Bank? bank,
  Function? copyAccountNbr,
}) =>
    Visibility(
      visible: !AppUtils.isNullValue(bank),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 15.h,
        ),
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Globe.bankName,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    bank?.name ?? '',
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Globe.bankAccNbr,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onLongPress: () => copyAccountNbr?.call(bank?.accNumber),
                    child: Text(
                      bank?.accNumber ?? '',
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Globe.bankBranch,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    bank?.address ?? '',
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Globe.holderName,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    bank?.accName ?? '',
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
