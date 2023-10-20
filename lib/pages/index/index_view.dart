import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/pages/home/home_view.dart';
import 'package:kaibo/pages/market/market_view.dart';
import 'package:kaibo/pages/environment/environment_view.dart';
import 'package:kaibo/pages/explore/explore_view.dart';
import 'package:kaibo/pages/mine/mine_view.dart';
import 'package:kaibo/widgets/bottom_nav_bar.dart';

import 'index_logic.dart';

class IndexPage extends StatelessWidget {
  final logic = Get.find<IndexLogic>();

  IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Styles.c_FFFFFF,
        body: IndexedStack(
          index: logic.index.value,
          children: [
            const HomePage(),
            const MarketPage(),
            EnvironmentPage(),
            ExplorePage(),
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
              imgWidth: 25.w,
              imgHeight: 25.h,
              onClick: logic.switchTab,
              showToast: true,
            ),
            BottomNavBarItem(
              selectedImgRes: ImageStr.icNavMarketSel,
              unselectedImgRes: ImageStr.icNavMarketNor,
              label: Globe.market,
              imgWidth: 25.w,
              imgHeight: 25.h,
              onClick: logic.switchTab,
              showToast: true,
            ),
            BottomNavBarItem(
              selectedImgRes: ImageStr.icNavEnvironmentSel,
              unselectedImgRes: ImageStr.icNavEnvironmentNor,
              label: Globe.environment,
              imgWidth: 25.w,
              imgHeight: 25.h,
              onClick: logic.switchTab,
              enableBtn: true,
            ),
            BottomNavBarItem(
              selectedImgRes: ImageStr.icNavBoxSel,
              unselectedImgRes: ImageStr.icNavBoxNor,
              label: Globe.explore,
              imgWidth: 25.w,
              imgHeight: 25.h,
              onClick: logic.switchTab,
              // enableBtn: logic.preload.value.canBuy == 1 ? true : false,
              // enableBtn: true,
              enableBtn: !logic.enableExploreShimmer.value && logic.preload.value.canBuy == 1,
              showToast: true,
            ),
            BottomNavBarItem(
              selectedImgRes: ImageStr.icNavMineSel,
              unselectedImgRes: ImageStr.icNavMineNor,
              label: Globe.mine,
              imgWidth: 25.w,
              imgHeight: 25.h,
              onClick: logic.switchTab,
              enableBtn: true,
            ),
          ],
        ),
      ),
    );
  }
}
