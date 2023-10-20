import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/shimmer/deposit_history_shimmer.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/models/history.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'deposit_history_logic.dart';

class DepositHistoryPage extends StatelessWidget {
  final logic = Get.find<DepositHistoryLogic>();

  DepositHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.depositHistory,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => logic.enableDepositHistoryShimmer.value
            ? const DepositHistoryShimmer()
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 10.h,
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
                    itemBuilder: (_, index) => _buildItemView(
                      logic.histories[index],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

Widget _buildItemView(DepositWithdrawalHistory depositInfo) => Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${depositInfo.amount}",
                  style: Styles.tsDefaultTxtClr20spBold,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: depositInfo.status == 0
                        ? Styles.pendingBtnBgClr
                        : depositInfo.status == 1
                            ? Styles.successBtnBgClr
                            : Styles.failedBtnBgClr,
                    border: Border.all(
                        color: depositInfo.status == 0
                            ? Styles.pendingClr
                            : depositInfo.status == 1
                                ? Styles.successClr
                                : Styles.failedClr,
                        width: 1.3.sp),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    depositInfo.status == 0
                        ? Globe.pending
                        : depositInfo.status == 1
                            ? Globe.success
                            : depositInfo.status == 2
                                ? Globe.failed
                                : Globe.rejected,
                    style: depositInfo.status == 0
                        ? Styles.tsPendingTxtClr16sp
                        : depositInfo.status == 1
                            ? Styles.tsSuccessTxtClr16sp
                            : Styles.tsFailedTxtClr16sp,
                  ),
                ),
              ],
            ),
            15.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  depositInfo.currency == 1
                      ? Globe.rmb
                      : depositInfo.currency == 2
                          ? Globe.usdt
                          : Globe.bsc,
                  style: Styles.tsSecondaryTxtClr16sp,
                ),
                Text(
                  AppUtils.formatDateTime(depositInfo.createdAt!),
                  style: Styles.tsSecondaryTxtClr16sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
