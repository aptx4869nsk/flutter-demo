import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/views/badge_view.dart';
import 'package:kaibo/resources/lang.dart';
import 'app_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    this.index = 0,
    required this.items,
  }) : super(key: key);
  final int index;
  final List<BottomNavBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: BorderDirectional(
          top: BorderSide(
            color: Styles.defaultShadowClr,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Styles.defaultShadowClr,
            blurRadius: 5.0,
            spreadRadius: 2,
            offset: const Offset(0, -2.0),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage(ImageStr.icNavBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: List.generate(
            items.length,
            (index) => _buildItemView(
                  i: index,
                  item: items.elementAt(index),
                )).toList(),
      ),
    );
  }

  Widget _buildItemView({required int i, required BottomNavBarItem item}) =>
      Expanded(
        child: Listener(
          onPointerDown: (_) {
            if (item.onClick != null && item.enableBtn == true) {
              item.onClick!(i);
            } else {
              if(item.showToast == true) AppWidget.showToast(Globe.comingSoon);
            }
          },
          child: i == 2
              ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        image: DecorationImage(
                          image: AssetImage(
                            (i == index
                                ? item.selectedImgRes
                                : item.unselectedImgRes),
                          ),
                          fit: BoxFit.contain
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          3.verticalSpace,
                          "双碳".toText
                            ..style = Styles.tsDefaultTxtClr16spBold,
                          "行动".toText
                            ..style = Styles.tsDefaultTxtClr16spBold,
                          3.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          (i == index
                              ? item.selectedImgRes.toImage
                              : item.unselectedImgRes.toImage)
                            ..width = item.imgWidth
                            ..height = item.imgHeight,
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Transform.translate(
                              offset: const Offset(2, -2),
                              child: BadgeView(count: item.count ?? 0),
                            ),
                          ),
                        ],
                      ),
                      4.verticalSpace,
                      item.label.toText
                        ..style = i == index
                            ? (item.selectedStyle ??
                                Styles.ts_theme_10sp_semibold)
                            : (item.unselectedStyle ??
                                Styles.tsDefaultTxtClr10sp),
                    ],
                  ),
                ),
        ),
      );
}

class BottomNavBarItem {
  final String selectedImgRes;
  final String unselectedImgRes;
  final String label;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final double imgWidth;
  final double imgHeight;
  final Function(int index)? onClick;
  final Function(int index)? onDoubleClick;
  final Stream<int>? steam;
  final int? count;
  final bool? enableBtn;
  final bool? showToast;

  BottomNavBarItem({
    required this.selectedImgRes,
    required this.unselectedImgRes,
    required this.label,
    this.selectedStyle,
    this.unselectedStyle,
    required this.imgWidth,
    required this.imgHeight,
    this.onClick,
    this.onDoubleClick,
    this.steam,
    this.count,
    this.enableBtn = false,
    this.showToast = false,
  });
}
