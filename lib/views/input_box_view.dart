import 'package:flutter/material.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputBoxView extends StatelessWidget {
  final String label;
  final String text;
  final String leadingIcon;
  final String? trailingTxt;
  final Function()? onClick;
  final Widget? customTrailing;

  const InputBoxView({
    Key? key,
    required this.label,
    required this.text,
    required this.leadingIcon,
    this.trailingTxt,
    this.onClick,
    this.customTrailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.tsDefaultTxtClr14sp,
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
          child: Row(
            children: [
              15.horizontalSpace,
              leadingIcon.toImage
                ..width = 28.w
                ..height = 28.h,
              10.horizontalSpace,
              Expanded(
                child: Text(
                  text,
                  style: Styles.tsDefaultTxtClr16sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: !(customTrailing == null &&
                    (trailingTxt == null || onClick == null)),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => onClick?.call(),
                  child: SizedBox(
                    width: 70.w,
                    height: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.defaultBtnBgClr,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
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
                      child: customTrailing ??
                          Center(
                            child: Text(
                              trailingTxt ?? '',
                              style: Styles.tsDefaultTxtClr14sp,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
