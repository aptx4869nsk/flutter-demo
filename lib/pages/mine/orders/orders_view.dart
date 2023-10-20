import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/utils/app_utils.dart';

import 'orders_logic.dart';

class OrdersPage extends StatelessWidget {
  final logic = Get.find<OrdersLogic>();

  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.myOrders,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SmartRefresher(
            controller: logic.controller,
            onLoading: logic.onLoading,
            enablePullDown: false,
            enablePullUp: true,
            header: AppWidget.buildHeader(),
            footer: AppWidget.buildFooter(),
            child: ListView.builder(
              itemCount: logic.histories.length,
              itemBuilder: (_, index) => _buildOrderRecord(
                logic.histories[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildOrderRecord(OrderHistory orderInfo) => Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
      ),
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
              children: [
                Text(
                  Globe.myProductName,
                  style: Styles.tsDefaultTxtClr14sp,
                ),
                Text(
                  orderInfo.product?.name ?? '',
                  style: Styles.tsDefaultTxtClr14sp,
                ),
              ],
            ),
            Divider(height: 20.h, thickness: 1.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Globe.interestRate,
                  style: Styles.tsDefaultTxtClr12sp,
                ),
                Text(
                  sprintf(Globe.orderInterestRate,
                      ['${orderInfo.earnRate! * 100}']),
                  style: Styles.tsDefaultTxtClr12sp,
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Globe.orderPrice,
                  style: Styles.tsDefaultTxtClr12sp,
                ),
                Text(
                  "${orderInfo.price}",
                  style: Styles.tsDefaultTxtClr12sp,
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Globe.startDate,
                  style: Styles.tsDefaultTxtClr12sp,
                ),
                Text(
                  AppUtils.formatDateTime(orderInfo.startTime!),
                  style: Styles.tsSecondaryTxtClr12sp,
                ),
              ],
            ),
            5.verticalSpace,
            Visibility(
              visible: orderInfo.status == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Globe.remainingDate,
                    style: Styles.tsDefaultTxtClr12sp,
                  ),
                  Text(
                    sprintf(Globe.orderRemainingDate,
                        [(AppUtils.remainingDays(orderInfo.endTime!))]),
                    style: Styles.tsSecondaryTxtClr12sp,
                  ),
                ],
              ),
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Globe.orderStatus,
                  style: Styles.tsDefaultTxtClr12sp,
                ),
                Text(
                  orderInfo.status == 1
                      ? Globe.orderStatusEnd
                      : Globe.orderStatusNormal,
                  style: Styles.tsDefaultTxtClr12sp,
                ),
              ],
            ),
            5.verticalSpace,
          ],
        ),
      ),
    );
