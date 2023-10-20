import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';

class ExploreShimmer extends StatelessWidget {
  const ExploreShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.explore(),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.transparent,
        child: Shimmer.fromColors(
          baseColor: Styles.shimmerBaseColor,
          highlightColor: Styles.shimmerHighLightColor,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(2, (index) => _buildItemView()),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildItemView() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Styles.cDefaultTxtClrOpacity20,
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image
            SizedBox(
              height: 140.h,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Styles.c_FFFFFF,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: double.infinity,
                          color: Styles.theme,
                          padding: EdgeInsets.only(left: 25.w),
                          child: Globe.productName.toText
                            ..style = Styles.tsDefaultTxtClr14sp,
                        ),
                        Container(
                          height: double.infinity,
                          color: Styles.theme,
                          padding: EdgeInsets.only(right: 15.w),
                          child: "XXX-XXX-XXX".toText
                            ..style = Styles.tsDefaultTxtClr14sp,
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  SizedBox(
                    height: 25.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: double.infinity,
                          color: Styles.theme,
                          padding: EdgeInsets.only(left: 25.w),
                          child: Globe.earnRate.toText
                            ..style = Styles.tsDefaultTxtClr14sp,
                        ),
                        Container(
                          height: double.infinity,
                          color: Styles.theme,
                          padding: EdgeInsets.only(right: 15.w),
                          child: "XX.XX%".toText
                            ..style = Styles.tsDefaultTxtClr14sp,
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    color: Styles.theme,
                  ),
                  15.verticalSpace,
                  Container(
                    width: double.infinity,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Styles.defaultBtnBgClr,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                    ),
                    child: Center(
                      child: Globe.buyNow.toText
                        ..style = Styles.tsDefaultTxtClr14spBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
