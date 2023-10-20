import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprintf/sprintf.dart';

import 'points_logic.dart';

class PointsPage extends StatelessWidget {
  final logic = Get.find<PointsLogic>();

  PointsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.myPoints,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sprintf(Globe.pointsCount, ['0']),
                style: Styles.tsDefaultTxtClr14sp,
              ),
              15.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: logic.swapPoints,
                      child: SizedBox(
                        height: 38.h,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Styles.defaultBtnBgClr,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Center(
                            child: Text(
                              Globe.swapPoints,
                              style: Styles.tsDefaultTxtClr14sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: logic.sellOutPoints,
                      child: SizedBox(
                        height: 38.h,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Styles.defaultBtnBgClr,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Center(
                            child: Text(
                              Globe.sellOutPoints,
                              style: Styles.tsDefaultTxtClr14sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
