import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:shimmer/shimmer.dart';

class CardsShimmer extends StatelessWidget {
  const CardsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: Shimmer.fromColors(
            baseColor: Styles.shimmerBaseColor,
            highlightColor: Styles.shimmerHighLightColor,
            child: Column(
              children: [
                _buildInputBoxView,
                10.verticalSpace,
                _buildInputBoxView,
                10.verticalSpace,
                _buildInputBoxView,
                10.verticalSpace,
                _buildInputBoxView,
                45.verticalSpace,
                SizedBox(
                  height: 48.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.defaultBtnBgClr,
                      borderRadius: BorderRadius.circular(10.sp),
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

Widget get _buildInputBoxView => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      height: 25.h,
      color: Styles.c_E2F2D1,
      child: Text(
        'XXXXXX',
        style: Styles.tsDefaultTxtClr14sp,
      ),
    ),
    6.verticalSpace,
    Container(
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
    ),
  ],
);
