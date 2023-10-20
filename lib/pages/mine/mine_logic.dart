import 'package:get/get.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/utils/logger.dart';

class MineLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final controller = RefreshController();

  void userSettings() => AppNavigator.startUserSettings();

  void userDeposit() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      AppNavigator.startUserVerification();
      return;
    } else if (indexLogic.preload.value.canDeposit == 0) {
      AppWidget.showToast(Globe.canNotDepositNow);
      return;
    } else if (indexLogic.profile.value.isWithdrawPasswordSet == 0) {
      AppWidget.showToast(Globe.plsSetWithdrawalPwd);
      return;
    } else {
      AppNavigator.startUserDeposit();
    }
  }

  void userWithdrawal() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      AppNavigator.startUserVerification();
      return;
    } else if (indexLogic.profile.value.isWithdrawPasswordSet == 0) {
      AppWidget.showToast(Globe.plsSetWithdrawalPwd);
      return;
    } else {
      AppNavigator.startUserWithdrawal();
    }
  }

  void userAssets() => AppNavigator.startUserAssets();

  void userOrders() => AppNavigator.startUserOrders();

  void userTeam() => AppNavigator.startUserTeam();

  void userInvitation() => AppNavigator.startUserInvitation();

  void userVerification() => AppNavigator.startUserVerification();

  void userCards() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      return;
    }
    AppNavigator.startUserCards();
  }

  void userUsdt() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      return;
    }
    AppNavigator.startUserUsdt();
  }

  void userPoints() => AppNavigator.startUserPoints();

  void userVersion() => AppNavigator.startUserVersion();

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  void refreshData({bool init = false}) async {
    try {
      indexLogic.getProfile();
      controller.refreshCompleted();
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      controller.refreshFailed();
      Logger.print('mine e: $e $s');
    }
  }
}


