import 'package:get/get.dart';
import 'package:kaibo/widgets/ad_dialog.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/models/preload.dart';
import 'package:kaibo/models/upgrade_info.dart';
import 'package:kaibo/models/product.dart';
import 'package:kaibo/models/profile.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/app_utils.dart';

class IndexLogic extends GetxController {
  final appLogic = Get.find<AppController>();

  // 0：首页，1：商城，2：双碳行动，3：美丽中国，4：我的
  final index = 2.obs;

  // pagination
  final pageSize = 10;

  // shimmer
  final enableEnvironmentShimmer = true.obs; // preload
  final enableEnvironmentNewsShimmer = true.obs; // news
  final enableExploreShimmer = true.obs;
  final enableMineShimmer = true.obs;

  // models
  final preload = Preload().obs;
  final upgradeInfo = UpgradeInfo().obs;
  final news = <NewsHistory>[].obs;
  final products = <Product>[].obs; // 美丽中国
  final profile = Profile().obs; // 我的

  @override
  void onReady() {
    // checkVersion();
    // getPreload(); // 首页配置
    // getNewsHistories(); // 双碳行动 - 新闻
    // getProducts(); // 美丽中国 - 产品
    // getProfile(); // 我的
    initializeData();
    super.onReady();
  }

  // 切换 Navigation Bottom Bar
  void switchTab(int i) {
    if (i == 2) {
      // environment - 双碳行动
      getPreload();
    } else if (i == 3)  {
      if(preload.value.canBuy == 0) {
        enableExploreShimmer.value = true;
      }
      // 美丽中国
      if (enableExploreShimmer.value && preload.value.canBuy == 1) {
        getProducts();
      }
    }
    index.value = i;
  }

  Future<void> checkVersion() async {
    final data = await Apis.checkUpgrade();
    upgradeInfo.value = data;
    getPreload(); // 首页配置
  }

  bool get canUpdate =>
      AppUtils.compareVersion(
        appLogic.packageInfo!.version,
        upgradeInfo.value.buildVersion!,
      ) <
      0;

  // 初始化
  void initializeData() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        // 1.check-version
        final upgradeData = await Apis.checkUpgrade();
        upgradeInfo.value = upgradeData;
        // 2.preload
        await Apis.preload().then((preloadData) async {
          preload.value = preloadData;
          enableEnvironmentShimmer.value = false;
          if (!canUpdate) {  // POPUP AD 广告弹窗
            if ((preload.value.popupAd?.status ?? 0) == 1) {
              Get.dialog(
                AdDialog(
                  title: preload.value.popupAd?.title,
                  htmlData: preload.value.popupAd?.body,
                ),
              );
            }
          }
          // 2-1.products - base on preload
          if(preloadData.canBuy == 1) {
            Products data = await Apis.products(
              page: 1,
              pageSize: pageSize,
            );
            products.value = data.products ?? [];
            enableExploreShimmer.value = false;
          }
        });
        // 3.news - after preload
        getNewsHistories();
        // 4.profile - after preload
        getProfile();
      } catch (e, s) {
        Logger.print('index e: $e $s');
      }
    });
  }

  // Preload - 初始化配置
  void getPreload() async {
    try {
      Preload data = await Apis.preload();
      preload.value = data;
      enableEnvironmentShimmer.value = false;
      // POPUP AD 广告弹窗
      if (!canUpdate) {
        if ((preload.value.popupAd?.status ?? 0) == 1) {
          Get.dialog(
            AdDialog(
              title: preload.value.popupAd?.title,
              htmlData: preload.value.popupAd?.body,
            ),
          );
        }
      }
      if (enableExploreShimmer.value && preload.value.canBuy == 1) {
        getProducts();
      }
    } catch (e, s) {
      Logger.print('index e: $e $s');
    }
    // LoadingView.singleton.wrap(asyncFunction: () async {
    //   try {
    //     Preload data = await Apis.preload();
    //     preload.value = data;
    //     enableEnvironmentShimmer.value = false;
    //     // POPUP AD 广告弹窗
    //     if (!canUpdate) {
    //       if ((preload.value.popupAd?.status ?? 0) == 1) {
    //         Get.dialog(
    //           AdDialog(
    //             title: preload.value.popupAd?.title,
    //             htmlData: preload.value.popupAd?.body,
    //           ),
    //         );
    //       }
    //     }
    //   } catch (e, s) {
    //     Logger.print('index e: $e $s');
    //   }
    // });
  }

  /// 获取新闻记录
  void getNewsHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        NewsHistories data = await Apis.getNewsHistories(
          page: 1,
          pageSize: 15,
        );
        news.value = data.histories ?? [];
        enableEnvironmentNewsShimmer.value = false;
      } catch (e, s) {
        Logger.print('index e: $e $s');
      }
    });
  }

  // Product - 美丽中国
  void getProducts() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        Products data = await Apis.products(
          page: 1,
          pageSize: pageSize,
        );
        products.value = data.products ?? [];
        enableExploreShimmer.value = false;
      } catch (e, s) {
        Logger.print('index e: $e $s');
      }
    });
  }

  // Profile - 我的
  void getProfile() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        Profile data = await Apis.profile();
        profile.value = data;
        enableMineShimmer.value = false;
      } catch (e, s) {
        Logger.print('index e: $e $s');
      }
    });
  }
}
