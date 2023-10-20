import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({
    Key? key,
    required this.title,
    required this.description,
    required this.btnTxt,
    this.onUpgrade,
  }) : super(key: key);
  final String title;
  final String description;
  final String btnTxt;
  final Function()? onUpgrade;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Container(
        decoration: BoxDecoration(
          color: Styles.c_E2F2D1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Text(
                title,
                style: Styles.tsDefaultTxtClr20spBold,
              ),
              15.verticalSpace,
              Text(
                description,
                style: Styles.tsSecondaryTxtClr14sp,
                textAlign: TextAlign.center,
              ),
              25.verticalSpace,
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onUpgrade?.call();
                  Get.back();
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.c_47B972,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
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
                    child: Center(
                      child: Text(
                        btnTxt,
                        style: Styles.tsDefaultTxtClr14spBold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
