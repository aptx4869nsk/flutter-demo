import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class OrdersLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final histories = <OrderHistory>[].obs;

  @override
  void onReady() {
    getOrderHistories();
    super.onReady();
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getOrderHistories(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.histories ?? [];
      if (lst.isEmpty) {
        page.value = page.value - 1;
        controller.loadNoData();
      } else {
        histories.addAll(lst);
        if (lst.length < pageSize) {
          controller.loadNoData();
        } else {
          controller.loadComplete();
        }
      }
    } catch (e, s) {
      page.value = page.value - 1;
      controller.loadFailed();
      Logger.print('orders e: $e $s');
    }
  }

  // 获取充值记录
  void getOrderHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        OrderHistories data = await Apis.getOrderHistories(
          page: page.value,
          pageSize: pageSize,
        );
        histories.value = data.histories ?? [];
      } catch (e, s) {
        Logger.print('orders e: $e $s');
      }
    });
  }
}
