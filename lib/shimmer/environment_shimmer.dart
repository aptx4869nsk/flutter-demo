import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kaibo/resources/styles.dart';

class EnvironmentShimmer extends StatelessWidget {
  const EnvironmentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerHighLightColor,
      child: Column(
        children: [
          SizedBox(
            height: 230.h,
            child: ClipRRect(
              child: Stack(
                children: [
                  // Video Swapper
                  Positioned(
                    child: Container(
                      height: 200.h,
                      color: Styles.theme,
                    ),
                  ),
                  // Check in
                  Positioned(
                    top: 180.h,
                    right: 20.w, // 40 + 20
                    child: SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Styles.defaultBtnBgClr,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          6.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                // marquee
                SizedBox(
                  height: 50.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_FFFFFF,
                      border:
                          Border.all(color: Styles.cThemeOpacity60, width: 1.w),
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Styles.cThemeOpacity40,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                15.verticalSpace,
                // company info
                SizedBox(
                  height: 90.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_FFFFFF,
                      border:
                          Border.all(color: Styles.cThemeOpacity60, width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Styles.cThemeOpacity40,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
