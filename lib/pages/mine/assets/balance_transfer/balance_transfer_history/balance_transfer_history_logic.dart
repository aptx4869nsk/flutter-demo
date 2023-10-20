import 'package:get/get.dart';
import 'package:kaibo/models/history.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/pages/index/index_logic.dart';

enum BalanceTransferType { cashIn, cashOut }

class BalanceTransferHistoryLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final selectedTransferType = BalanceTransferType.cashIn.obs;
  final histories = <TransactionHistory>[].obs;
  final enableTransferHistoryShimmer = true.obs;

  @override
  void onReady() {
    getTransactionHistories();
    super.onReady();
  }

  BalanceTransferType get transferType => selectedTransferType.value;

  // 转入/转出
  void toggleTransferType(BalanceTransferType type) {
    selectedTransferType.value = type;
    page.value = 1;
    getTransactionHistories();
  }

  /// 001-收入, 002-转出
  void getTransactionHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        TransactionHistories data = await Apis.getTransactionHistories(
          page: page.value,
          pageSize: pageSize,
          code: transferType == BalanceTransferType.cashIn ? '011' : '012',
        );
        histories.value = data.histories ?? [];
        enableTransferHistoryShimmer.value = false;
      } catch (e, s) {
        Logger.print('transfer history e: $e $s');
      }
    });
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getTransactionHistories(
        page: page.value,
        pageSize: pageSize,
        code: transferType == BalanceTransferType.cashIn ? '001' : '002',
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
      Logger.print('transfer history e: $e $s');
    }
  }
}
