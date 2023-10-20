import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/models/transaction_types.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/shimmer/assets_shimmer.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/widgets/custom_dropdown.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/utils/app_utils.dart';

import 'assets_logic.dart';

class AssetsPage extends StatelessWidget {
  final logic = Get.find<AssetsLogic>();

  AssetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => logic.enableAssetsShimmer.value
            ? const AssetsShimmer()
            : Column(
                children: [
                  _assetsHeader(
                    context,
                    points: logic.points.value,
                    balance: logic.balance.value,
                    onTapUserTransfer: logic.userTransfer,
                    onTapSwapPoints: logic.userPoints,
                  ),
                  // 资金日志
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      height: 52.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Globe.assetsLog,
                            style: Styles.tsDefaultTxtClr14sp,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Styles.c_FFFFFF,
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
                            child: SizedBox(
                              height: 20.h,
                              child: CustomDropdownMenu<TransactionType>(
                                onSelected: (item) =>
                                    logic.onChangeTransactionType(item),
                                itemBuilder: (BuildContext context) {
                                  return List<
                                          PopupMenuEntry<
                                              TransactionType>>.generate(
                                      logic.transactionTypes.length * 2 - 1,
                                      (int index) {
                                    if (index.isEven) {
                                      final item =
                                          logic.transactionTypes[index ~/ 2];
                                      return CustomDropdownMenuItem<
                                          TransactionType>(
                                        value: item,
                                        text: item.name ?? '',
                                      );
                                    } else {
                                      return const DropdownDivider();
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      logic.transactionName.value,
                                      style: Styles.tsDefaultTxtClr14sp,
                                    ),
                                    5.horizontalSpace,
                                    ImageStr.icArrowDown.toImage,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: SmartRefresher(
                        controller: logic.controller,
                        onLoading: logic.onLoading,
                        enablePullDown: false,
                        enablePullUp: true,
                        header: AppWidget.buildHeader(),
                        footer: AppWidget.buildFooter(),
                        child: ListView.builder(
                          itemCount: logic.histories.length,
                          itemBuilder: (_, index) => _buildAssetsRecord(
                            historyInfo: logic.histories[index],
                            getName: logic.getTransactionName,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget _assetsHeader(
  BuildContext context, {
  String? points,
  String? balance,
  Function()? onTapUserTransfer,
  Function()? onTapSwapPoints,
}) =>
    SizedBox(
      width: 1.sw,
      height: 220.h,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageStr.icMineBg),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                Globe.points,
                                style: Styles.tsDefaultTxtClr14spBold,
                              ),
                              6.verticalSpace,
                              Text(
                                points ?? '',
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1.w,
                          height: 55.h,
                          color: Styles.defaultDividerClr,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                Globe.balance,
                                style: Styles.tsDefaultTxtClr14spBold,
                              ),
                              6.verticalSpace,
                              Text(
                                balance ?? '',
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => onTapSwapPoints?.call(),
                          child: Container(
                            width: 1.sw / 3 * 2 - 20.w,
                            decoration: BoxDecoration(
                              color: Styles.defaultBtnBgClr,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: Center(
                                child: Text(
                                  Globe.pointsToBalance,
                                  style: Styles.tsDefaultTxtClr14sp,
                                ),
                              ),
                              // Text(
                              //   Globe.balance,
                              //   style: Styles.tsDefaultTxtClr14spBold,
                              // ),
                              // 6.verticalSpace,
                              // Text(
                              //   balance ?? '',
                              //   style: Styles.tsDefaultTxtClr14sp,
                              // ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => onTapUserTransfer?.call(),
                          child: Container(
                            width: 1.sw / 3 - 20.w,
                            decoration: BoxDecoration(
                              color: Styles.defaultBtnBgClr,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: Center(
                                child: Text(
                                  Globe.userTransfer,
                                  style: Styles.tsDefaultTxtClr14sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget _buildAssetsRecord({
  required TransactionHistory historyInfo,
  required Function getName,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Styles.c_E2F2D1,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getName.call(historyInfo.type),
                  style: Styles.tsDefaultTxtClr14sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      historyInfo.amount ?? '',
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    6.verticalSpace,
                    Text(
                      AppUtils.formatDateTime(historyInfo.createdAt!),
                      style: Styles.tsSecondaryTxtClr12sp,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
