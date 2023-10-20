import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';

class MineShimmer extends StatelessWidget {
  const MineShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Styles.shimmerBaseColor,
      highlightColor: Styles.shimmerHighLightColor,
      child: Column(
        children: [
          _profileHeader(context),
          10.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            child: Column(
              children: List.generate(
                9,
                (index) => _buildItemView(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _profileHeader(BuildContext context) => SizedBox(
      width: 1.sw,
      height: 220.h,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageStr.icMineBg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

Widget _buildItemView() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 48.h,
        child: Container(
          decoration: BoxDecoration(
            color: Styles.c_E2F2D1,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                color: Styles.cDefaultTxtClrOpacity20,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 55.w,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Styles.c_C6E37E,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: Container(
                            width: 25.w,
                            height: 25.h,
                            color: Styles.theme,
                          ),
                        ),
                      ),
                    ),
                    15.horizontalSpace,
                    "XXXXXXXX".toText..style = Styles.tsDefaultTxtClr14sp
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: 'XXXX'.toText..style = Styles.tsDefaultTxtClr14sp,
                    ),
                    5.horizontalSpace,
                    Align(
                      alignment: const Alignment(1.0, 0.0),
                      child: Container(
                        width: 15.w,
                        height: 15.h,
                        color: Styles.theme,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      10.verticalSpace
    ],
  );
}
