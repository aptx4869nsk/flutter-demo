import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/models/product.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/routes/app_navigator.dart';

class ExploreLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final indexLogic = Get.find<IndexLogic>();
  final canBuy = false.obs;
  final buyStartTime = ''.obs;
  final buyEndTime = ''.obs;

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  void refreshData({bool init = false}) async {
    try {
      page.value = 1;
      var data = await Apis.products(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.products ?? [];
      if (lst.isEmpty) {
        controller.loadNoData();
      } else {
        indexLogic.products.value = lst;
        controller.refreshCompleted();
      }
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      controller.refreshFailed();
      Logger.print('mine e: $e $s');
    }
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.products(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.products ?? [];
      if (lst.isEmpty) {
        page.value = page.value - 1;
        controller.loadNoData();
      } else {
        indexLogic.products.addAll(lst);
        if (lst.length < pageSize) {
          controller.loadNoData();
        } else {
          controller.loadComplete();
        }
      }
    } catch (e, s) {
      page.value = page.value - 1;
      controller.loadFailed();
      Logger.print('explore e: $e $s');
    }
  }

  void buy(Product product) async {
    canBuy.value = indexLogic.preload.value.canBuy == 1 ? true : false;
    buyStartTime.value = indexLogic.preload.value.buyProductTime?.start ?? '';
    buyEndTime.value = indexLogic.preload.value.buyProductTime?.end ?? '';
    // buy validation
    if (!canBuy.value) {
      AppWidget.showToast(Globe.denyBuy);
      return;
    }
    // // account verification
    // if (indexLogic.profile.value.card?.status != 2) {
    //   AppWidget.showToast(Globe.plsVerifiedAcc);
    //   AppNavigator.startUserVerification();
    //   return;
    // }
    // time validation
    final dateUtc = DateTime.now().toUtc();
    final localTime = dateUtc.toLocal();
    String currentDT =
        DateUtil.formatDate(localTime, format: "yyyy-MM-dd HH:mm:ss");
    var dateTime = currentDT.split(' ');
    String currentDate = dateTime[0];
    String startTime = buyStartTime.value;
    String endTime = buyEndTime.value;
    String depositStartTime = "$currentDate $startTime";
    String depositEndTime = "$currentDate $endTime";
    DateTime dt1Start = DateTime.parse(depositStartTime);
    DateTime dt1End = DateTime.parse(depositEndTime);
    DateTime dt2 = DateTime.parse(currentDT);
    // < 0 - DT1 is before DT2, > 0 - DT1 is after DT2
    if (!(dt2.compareTo(dt1Start) > 0 && dt2.compareTo(dt1End) < 0)) {
      String msg = sprintf(Globe.buyProductTime, [startTime, endTime]);
      AppWidget.showToast(msg);
      return;
    }
    AppNavigator.startBuyProduct(product: product);
  }
}
