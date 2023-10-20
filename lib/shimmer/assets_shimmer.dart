import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:get/get.dart';

class AssetsShimmer extends StatelessWidget {
  const AssetsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Column(
        children: [
          _assetsHeader(context),
          // 资金日志
          Shimmer.fromColors(
            baseColor: Styles.shimmerBaseColor,
            highlightColor: Styles.shimmerHighLightColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 52.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 55.w, height: 25.h, color: Styles.c_FFFFFF),
                    Container(
                      width: 90.w,
                      height: 35.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Styles.c_FFFFFF,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, index) => _buildAssetsRecord,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _assetsHeader(context) => SizedBox(
      width: 1.sw,
      height: 220.h,
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
            6.verticalSpace,
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Styles.shimmerBaseColor,
                highlightColor: Styles.shimmerHighLightColor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Styles.theme,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget get _buildAssetsRecord => Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerHighLightColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Container(
          height: 60.h,
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
        ),
      ),
    );
