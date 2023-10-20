part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  // environment
  static const notification = '/notification';
  static const news = '/news';
  static const newsDetail = '/news-detail';
  // explore
  static const buyProduct = '/buy-product';
  // mine
  static const userSettings = '/user_settings';
  static const userDeposit = '/user_deposit';
  static const userDepositHistory = '/user_deposit_history';
  static const userWithdrawal = '/user_withdrawal';
  static const userWithdrawalHistory = '/user_withdrawal_history';
  static const userAssets = '/user_assets';
  static const walletTransfer = '/wallet_transfer';
  static const userOrders = '/user_orders';
  static const userTeam = '/user_team';
  static const userInvitation = '/user_invitation';
  static const userVerification = '/user_verification';
  static const userCards = '/user_cards';
  static const userUsdt = '/user_usdt';
  static const userPoints = '/user_points';
  static const userVersion = '/user_version';
  // mine => user-assets => transfer
  static const pointsTransfer = '/points_transfer';
  static const pointsTransferHistory = '/points_transfer_history';
  static const balanceTransfer = '/balance_transfer';
  static const balanceTransferHistory = '/balance_transfer_history';
  // mine => user-settings
  static const modifyPhone = '/modify_phone';
  static const modifyLoginPwd = '/modify_login_pwd';
  static const modifyBillingAddr = '/modify_billing_address';
  static const modifyWithdrawalPwd = "/modify_withdrawal_pwd";
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
