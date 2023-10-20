import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/custom_ext.dart';

class EnvironmentNewsShimmer extends StatelessWidget {
  const EnvironmentNewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
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
                      border: Border.all(
                          color: Styles.cThemeOpacity60, width: 1.w),
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
                      border: Border.all(
                          color: Styles.cThemeOpacity60, width: 1.w),
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
                // More News
                SizedBox(
                  height: 25.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: double.infinity,
                        color: Styles.theme,
                        padding: EdgeInsets.only(left: 25.w),
                        child: Globe.news.toText
                          ..style = Styles.tsDefaultTxtClr14sp,
                      ),
                      Container(
                        height: double.infinity,
                        color: Styles.theme,
                        padding: EdgeInsets.only(right: 15.w),
                        child: Globe.newsMore.toText
                          ..style = Styles.tsDefaultTxtClr14sp,
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                // News
                SizedBox(
                  height: 130.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_E2F2D1,
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
                  ),
                ),
                6.verticalSpace,
                SizedBox(
                  height: 130.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_E2F2D1,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
