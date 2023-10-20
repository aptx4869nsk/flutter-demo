import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/shimmer/transfer_history_shimmer.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'balance_transfer_history_logic.dart';

class BalanceTransferHistoryPage extends StatelessWidget {
  final logic = Get.find<BalanceTransferHistoryLogic>();

  BalanceTransferHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.transferHistory,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => logic.enableTransferHistoryShimmer.value
            ? const TransferHistoryShimmer()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  children: [
                    _transferTypeToggle(
                      toggle: logic.toggleTransferType,
                      type: logic.transferType,
                    ),
                    15.verticalSpace,
                    Expanded(
                      child: SmartRefresher(
                        controller: logic.controller,
                        onLoading: logic.onLoading,
                        enablePullDown: false,
                        enablePullUp: true,
                        header: AppWidget.buildHeader(),
                        footer: AppWidget.buildFooter(),
                        child: ListView.builder(
                          itemCount: logic.histories.length,
                          itemBuilder: (_, index) => _buildTransferRecord(
                              transferInfo: logic.histories[index],
                              type: logic.transferType),
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

Widget _transferTypeToggle({
  required Function toggle,
  required BalanceTransferType type,
}) =>
    SizedBox(
      height: 52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(BalanceTransferType.cashIn),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: type == BalanceTransferType.cashIn
                      ? Styles.defaultBtnBgClr
                      : Styles.c_E2F2D1,
                  borderRadius: BorderRadius.circular(8.r),
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
                    ImageStr.icIn.toImage
                      ..width = 25.w
                      ..height = 25.h,
                    10.horizontalSpace,
                    Text(
                      Globe.transferIn,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          15.horizontalSpace,
          Expanded(
            child: InkWell(
              onTap: () => toggle.call(BalanceTransferType.cashOut),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: type == BalanceTransferType.cashOut
                      ? Styles.defaultBtnBgClr
                      : Styles.c_E2F2D1,
                  borderRadius: BorderRadius.circular(8.r),
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
                    ImageStr.icOut.toImage
                      ..width = 25.w
                      ..height = 25.h,
                    10.horizontalSpace,
                    Text(
                      Globe.transferOut,
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

Widget _buildTransferRecord({
  required TransactionHistory transferInfo,
  required BalanceTransferType type,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Styles.c_E2F2D1,
          borderRadius: BorderRadius.circular(8.r),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          type == BalanceTransferType.cashIn
                              ? Globe.transferOutAcc
                              : Globe.transferOutAcc,
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        6.horizontalSpace,
                        Text(
                          transferInfo.effectUser?.phone ?? '',
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          type == BalanceTransferType.cashIn
                              ? Globe.transferInAccName
                              : Globe.transferOutAccName,
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        6.horizontalSpace,
                        Text(
                          transferInfo.effectUser?.name ?? '',
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  transferInfo.amount ?? '',
                  style: Styles.tsDefaultTxtClr20spBold,
                ),
              ],
            ),
            10.verticalSpace,
            Text(
              AppUtils.formatDateTime(transferInfo.createdAt!),
              style: Styles.tsDefaultTxtClr14sp,
            ),
          ],
        ),
      ),
    );
