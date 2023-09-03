import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/pages/home/home_view.dart';
import 'package:kaibo/pages/mine/mine_view.dart';
import 'package:kaibo/widgets/bottom_nav_bar.dart';
import 'index_logic.dart';

class IndexPage extends StatelessWidget {
  final logic = Get.find<IndexLogic>();

  IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Styles.c_FFFFFF,
      body: IndexedStack(
        index: logic.index.value,
        children: const [
          HomePage(),
          MinePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        index: logic.index.value,
        items: [
          BottomNavBarItem(
            selectedImgRes: ImageStr.icNavHomeSel,
            unselectedImgRes: ImageStr.icNavHomeNor,
            label: Globe.home,
            imgWidth: 28.w,
            imgHeight: 28.h,
            onClick: logic.switchTab,
          ),
          BottomNavBarItem(
            selectedImgRes: ImageStr.icNavMineSel,
            unselectedImgRes: ImageStr.icNavMineNor,
            label: Globe.mine,
            imgWidth: 28.w,
            imgHeight: 28.h,
            onClick: logic.switchTab,
          ),
        ],
      ),
    ));
  }
}
