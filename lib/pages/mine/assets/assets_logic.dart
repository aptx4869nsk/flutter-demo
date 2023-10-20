import 'package:get/get.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/models/transaction_types.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/models/history.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';

import 'package:kaibo/widgets/bottom_sheet.dart';

class AssetsLogic extends GetxController {
  final page = 1.obs;
  final indexLogic = Get.find<IndexLogic>();

  final transactionName = ''.obs;
  final transactionCode = ''.obs;
  final histories = <TransactionHistory>[].obs;
  final controller = RefreshController();
  final pageSize = 0.obs;
  final points = ''.obs; // 账户积分
  final balance = ''.obs; // 余额宝
  final transactionTypes = <TransactionType>[].obs; // 我的资产
  final enableAssetsShimmer = true.obs;

  @override
  void onInit() {
    transactionName.value = Globe.all;
    pageSize.value = indexLogic.pageSize;
    points.value = indexLogic.profile.value.balance ?? '';
    balance.value = indexLogic.profile.value.canWithdrawBalance ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    getTransactionTypes();
    super.onReady();
  }

  void userPoints() => AppNavigator.startWalletTransfer();

  void userTransfer() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      AppNavigator.startUserVerification();
      return;
    } else if (indexLogic.profile.value.isWithdrawPasswordSet == 0) {
      AppWidget.showToast(Globe.plsSetWithdrawalPwd);
      return;
    } else if (indexLogic.preload.value.canTransfer == 0) {
      AppWidget.showToast(Globe.canNotTransfer);
      return;
    } else {
      Get.bottomSheet(
        BottomSheet(
          items: [
            SheetItem(
              label: Globe.pointsTransfer,
              onTap: () => AppNavigator.startPointsTransfer(),
            ),
            SheetItem(
              label: Globe.balanceTransfer,
              onTap: () => AppNavigator.startBalanceTransfer(),
            ),
          ],
        ),
      );
    }
  }

  void onChangeTransactionType(TransactionType item) {
    transactionName.value = item.name ?? '';
    transactionCode.value = item.code ?? '';
    page.value = 1;
    getTransactionHistories();
  }

  /// 获取资金记录
  void getTransactionHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        TransactionHistories data = await Apis.getTransactionHistories(
          page: page.value,
          code: transactionCode.value,
        );
        histories.value = data.histories ?? [];
        enableAssetsShimmer.value = false;
      } catch (e, s) {
        Logger.print('assets e: $e $s');
      }
    });
  }

  /// 获取资产类型
  void getTransactionTypes() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        TransactionTypes data = await Apis.getTransactionTypes();
        transactionTypes.value = data.transactionTypes ?? [];
        transactionTypes.add(TransactionType(code: '', name: '全部'));
        getTransactionHistories();
      } catch (e, s) {
        Logger.print('assets e: $e $s');
      }
    });
  }

  /// 获取资产名称
  String getTransactionName(String type) {
    final transaction = transactionTypes.firstWhere(
      (element) => element.code == type,
      orElse: () => TransactionType(code: '', name: ''),
    );
    return transaction.name ?? '';
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getTransactionHistories(
        page: page.value,
        code: transactionCode.value,
      );
      var lst = data.histories ?? [];
      if (lst.isEmpty) {
        page.value = page.value - 1;
        controller.loadNoData();
      } else {
        histories.addAll(lst);
        if (lst.length < pageSize.value) {
          controller.loadNoData();
        } else {
          controller.loadComplete();
        }
      }
    } catch (e, s) {
      page.value = page.value - 1;
      controller.loadFailed();
      Logger.print('assets e: $e $s');
    }
  }
}
