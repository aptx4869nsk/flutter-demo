import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/lang.dart';
import '../routes/app_navigator.dart';
import '../widgets/title_bar.dart';

class DepositShimmer extends StatelessWidget {
  const DepositShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.userDeposit,
        backgroundColor: Styles.defaultAppBarBgClr,
        right: Globe.history.toText
          ..style = Styles.tsDefaultTxtClr16sp
          ..onTap = () => AppNavigator.startUserDepositHistory(),
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Shimmer.fromColors(
            baseColor: Styles.shimmerBaseColor,
            highlightColor: Styles.shimmerHighLightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputBoxView,
                10.verticalSpace,
                Container(
                  height: 25.h,
                  color: Styles.c_E2F2D1,
                  child: Globe.depositType.toText
                    ..style = Styles.tsDefaultTxtClr14sp,
                ),
                6.verticalSpace,
                _depositTypeToggle,
                20.verticalSpace,
                _usdtInfo,
                20.verticalSpace,
                Container(
                  height: 25.h,
                  color: Styles.c_E2F2D1,
                  child: Globe.paidScreenshot.toText
                    ..style = Styles.tsDefaultTxtClr14sp,
                ),
                10.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 190.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_E2F2D1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                45.verticalSpace,
                SizedBox(
                  height: 48.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_E2F2D1,
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

Widget get _depositTypeToggle => SizedBox(
      height: 52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Styles.c_E2F2D1, width: 1),
                borderRadius: BorderRadius.circular(8.r),
                color: Styles.c_E2F2D1,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 1), //
                  ),
                ],
              ),
            ),
          ),
          15.horizontalSpace,
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Styles.c_E2F2D1, width: 1),
                borderRadius: BorderRadius.circular(8.r),
                color: Styles.c_E2F2D1,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 1), //
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget get _buildInputBoxView => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 25.h,
          color: Styles.c_E2F2D1,
          child: Text(
            'LABEL',
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

Widget get _usdtInfo => Container(
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
    );
