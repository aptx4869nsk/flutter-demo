import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:shimmer/shimmer.dart';

class DepositHistoryShimmer extends StatelessWidget {
  const DepositHistoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, index) => _buildItemView(),
        ),
      ),
    );
  }
}

Widget _buildItemView() => Padding(
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
    child: Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerHighLightColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Styles.defaultTxtClr,
                height: 25.h,
                child: "XXXXXX".toText
                  ..style = Styles.tsDefaultTxtClr20spBold,
              ),
              Container(
                width: 90.w,
                height: 35.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Styles.defaultTxtClr,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Styles.defaultTxtClr,
                height: 25.h,
                child: "XXXX".toText
                  ..style = Styles.tsSecondaryTxtClr16sp,
              ),
              Container(
                color: Styles.defaultTxtClr,
                height: 25.h,
                child: "XXXX-XX-XX XX:XX:XX".toText
                  ..style = Styles.tsSecondaryTxtClr16sp,
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
