import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:shimmer/shimmer.dart';

class TransferHistoryShimmer extends StatelessWidget {
  const TransferHistoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _transferTypeToggle(),
              15.verticalSpace,
              Column(
                children: List.generate(
                  5,
                  (index) => _buildTransferRecord(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _transferTypeToggle() => Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerHighLightColor,
      child: SizedBox(
        height: 52.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
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
              ),
            ),
            15.horizontalSpace,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
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
              ),
            ),
          ],
        ),
      ),
    );

Widget _buildTransferRecord() => Padding(
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
        child: Shimmer.fromColors(
          baseColor: Styles.shimmerBaseColor,
          highlightColor: Styles.shimmerHighLightColor,
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
                      Container(
                        height: 25.h,
                        color: Styles.defaultTxtClr,
                        child: Row(
                          children: [
                            "XXXX".toText..style = Styles.tsDefaultTxtClr14sp,
                            6.horizontalSpace,
                            "XXXXXXXXXX".toText
                              ..style = Styles.tsDefaultTxtClr14sp,
                          ],
                        ),
                      ),
                      6.verticalSpace,
                      Container(
                        height: 25.h,
                        color: Styles.defaultTxtClr,
                        child: Row(
                          children: [
                            "XXXX".toText..style = Styles.tsDefaultTxtClr14sp,
                            6.horizontalSpace,
                            "XXXXX".toText
                              ..style = Styles.tsDefaultTxtClr14sp,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 80.w,
                    height: 35.h,
                    color: Styles.defaultTxtClr,
                  ),
                ],
              ),
              10.verticalSpace,
              Container(
                color: Styles.defaultTxtClr,
                height: 25.h,
                child: "2023-09-22 23:08:52".toText
                  ..style = Styles.tsSecondaryTxtClr16sp,
              ),
            ],
          ),
        ),
      ),
    );
