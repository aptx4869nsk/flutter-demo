import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:shimmer/shimmer.dart';

class NewsDetailShimmer extends StatelessWidget {
  const NewsDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Shimmer.fromColors(
        baseColor: Styles.shimmerBaseColor,
        highlightColor: Styles.shimmerHighLightColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 190.h,
                  child: Container(
                    color: Styles.theme,
                  ),
                ),
                15.verticalSpace,
                SizedBox(
                  width: 90.w,
                  height: 30.h,
                  child: Container(
                    color: Styles.theme,
                  ),
                ),
                10.verticalSpace,
                _buildParagraph(2),
                10.verticalSpace,
                _buildParagraph(6),
                25.verticalSpace,
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 140.w,
                    height: 20.h,
                    child: Container(
                      color: Styles.theme,
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

Widget _buildParagraph(int lines) => Column(
      children: [
        SizedBox(
          height: 20.h,
          child: Padding(
            padding: EdgeInsets.only(left: 45.w),
            child: Container(
              color: Styles.theme,
            ),
          ),
        ),
        5.verticalSpace,
        Column(
          children: List.generate(
            lines,
            (index) => _buildLine,
          ).toList(),
        ),
        SizedBox(
          height: 20.h,
          child: Container(
            color: Styles.theme,
          ),
        ),
        5.verticalSpace,
        SizedBox(
          height: 20.h,
          child: Padding(
            padding: EdgeInsets.only(right: 25.w),
            child: Container(
              color: Styles.theme,
            ),
          ),
        ),
      ],
    );

Widget get _buildLine => Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: SizedBox(
        height: 20.h,
        child: Container(
          color: Styles.theme,
        ),
      ),
    );
