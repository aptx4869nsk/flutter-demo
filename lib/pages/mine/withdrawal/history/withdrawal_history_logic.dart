import 'package:get/get.dart';
import 'package:kaibo/models/history.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class WithdrawalHistoryLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final histories = <DepositWithdrawalHistory>[].obs;
  final enableWithdrawalShimmer = true.obs;

  @override
  void onReady() {
    getWithdrawalHistories();
    super.onReady();
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.withdrawalHistories(
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
    }
  }

  // 获取提现记录
  void getWithdrawalHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        DepositWithdrawalHistories data = await Apis.withdrawalHistories(
          page: page.value,
          pageSize: pageSize,
        );
        histories.value = data.histories ?? [];
        enableWithdrawalShimmer.value = false;
      } catch (e, s) {
        Logger.print('withdrawal history e: $e $s');
      }
    });
  }
}
