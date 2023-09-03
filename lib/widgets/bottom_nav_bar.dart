import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/views/badge_view.dart';

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
        color: Styles.c_FFFFFF,
        border: BorderDirectional(
          top: BorderSide(
            color: Styles.c_E8EAEF,
            width: 1,
          ),
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
            if (item.onClick != null) item.onClick!(i);
          },
          child: Container(
            color: Styles.c_FFFFFF,
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
                      ? (item.selectedStyle ?? Styles.ts_theme_10sp_semibold)
                      : (item.unselectedStyle ??
                          Styles.ts_8E9AB0_10sp_semibold),
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
  });
}
