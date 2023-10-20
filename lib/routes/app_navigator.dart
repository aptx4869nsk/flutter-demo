import 'package:get/get.dart';
import 'app_pages.dart';
import 'package:kaibo/models/product.dart';

class AppNavigator {
  AppNavigator._();

  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void startBackLogin() {
    Get.until((route) => Get.currentRoute == AppRoutes.login);
  }

  static void startMain({bool isAutoLogin = false}) {
    Get.offAllNamed(AppRoutes.home);
  }

  static void startBackMain() {
    Get.until((route) => Get.currentRoute == AppRoutes.home);
  }

  static startRegister() => Get.toNamed(AppRoutes.register);

  // environment
  static startNotification() => Get.toNamed(AppRoutes.notification);

  static startNews() => Get.toNamed(AppRoutes.news);

  static startNewsDetail({required int id}) => Get.toNamed(
        AppRoutes.newsDetail,
        arguments: {
          'id': id,
        },
      );

  // explore
  static startBuyProduct({required Product product}) =>
      Get.toNamed(AppRoutes.buyProduct, arguments: {
        'product': product,
      });

  // mine
  static startUserSettings() => Get.toNamed(AppRoutes.userSettings);

  static startUserDeposit() => Get.toNamed(AppRoutes.userDeposit);

  static startUserWithdrawal() => Get.toNamed(AppRoutes.userWithdrawal);

  static startUserAssets() => Get.toNamed(AppRoutes.userAssets);

  static startPointsTransfer() => Get.toNamed(AppRoutes.pointsTransfer);

  static startBalanceTransfer() => Get.toNamed(AppRoutes.balanceTransfer);

  static startWalletTransfer() => Get.toNamed(AppRoutes.walletTransfer);

  static startUserOrders() => Get.toNamed(AppRoutes.userOrders);

  static startUserTeam() => Get.toNamed(AppRoutes.userTeam);

  static startUserInvitation() => Get.toNamed(AppRoutes.userInvitation);

  static startUserVerification() => Get.toNamed(AppRoutes.userVerification);

  static startUserCards() => Get.toNamed(AppRoutes.userCards);

  static startUserUsdt() => Get.toNamed(AppRoutes.userUsdt);

  static startUserPoints() => Get.toNamed(AppRoutes.userPoints);

  static startUserVersion() => Get.toNamed(AppRoutes.userVersion);

  // deposit => deposit-history
  static startUserDepositHistory() => Get.toNamed(AppRoutes.userDepositHistory);

  // withdrawal => withdrawal-history
  static startUserWithdrawalHistory() =>
      Get.toNamed(AppRoutes.userWithdrawalHistory);

  // mine => user-assets => transfer
  //  points-transfer-history
  static startPointsTransferHistory() =>
      Get.toNamed(AppRoutes.pointsTransferHistory);

  //  balance-transfer-history
  static startBalanceTransferHistory() =>
      Get.toNamed(AppRoutes.balanceTransferHistory);

  // mine => user-settings
  static startModifyPhone() => Get.toNamed(AppRoutes.modifyPhone);

  static startModifyLoginPwd() => Get.toNamed(AppRoutes.modifyLoginPwd);

  static startModifyBillingAddr() => Get.toNamed(AppRoutes.modifyBillingAddr);

  static startModifyWithdrawalPwd() =>
      Get.toNamed(AppRoutes.modifyWithdrawalPwd);
}
