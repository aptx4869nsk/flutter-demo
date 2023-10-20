import 'package:get/get.dart';
import 'package:kaibo/pages/splash/splash_binding.dart';
import 'package:kaibo/pages/splash/splash_view.dart';
import 'package:kaibo/pages/auth/login/login_binding.dart';
import 'package:kaibo/pages/auth/login/login_view.dart';
import 'package:kaibo/pages/auth/register/register_binding.dart';
import 'package:kaibo/pages/auth/register/register_view.dart';
import 'package:kaibo/pages/index/index_binding.dart';
import 'package:kaibo/pages/index/index_view.dart';

// environment
import 'package:kaibo/pages/environment/notice/notice_binding.dart';
import 'package:kaibo/pages/environment/notice/notice_view.dart';
import 'package:kaibo/pages/environment/news/news_binding.dart';
import 'package:kaibo/pages/environment/news/news_view.dart';
import 'package:kaibo/pages/environment/news/news_detail/news_detail_binding.dart';
import 'package:kaibo/pages/environment/news/news_detail/news_detail_view.dart';

// explore
import 'package:kaibo/pages/explore/product/product_binding.dart';
import 'package:kaibo/pages/explore/product/product_view.dart';

// mine
import 'package:kaibo/pages/mine/user_settings/user_settings_binding.dart';
import 'package:kaibo/pages/mine/user_settings/user_settings_view.dart';
import 'package:kaibo/pages/mine/deposit/deposit_binding.dart';
import 'package:kaibo/pages/mine/deposit/deposit_view.dart';
import 'package:kaibo/pages/mine/deposit/history/deposit_history_binding.dart';
import 'package:kaibo/pages/mine/deposit/history/deposit_history_view.dart';
import 'package:kaibo/pages/mine/withdrawal/withdrawal_binding.dart';
import 'package:kaibo/pages/mine/withdrawal/withdrawal_view.dart';
import 'package:kaibo/pages/mine/withdrawal/history/withdrawal_history_binding.dart';
import 'package:kaibo/pages/mine/withdrawal/history/withdrawal_history_view.dart';
import 'package:kaibo/pages/mine/assets/balance_transfer/balance_transfer_binding.dart';
import 'package:kaibo/pages/mine/assets/balance_transfer/balance_transfer_view.dart';
import 'package:kaibo/pages/mine/assets/balance_transfer/balance_transfer_history/balance_transfer_history_binding.dart';
import 'package:kaibo/pages/mine/assets/balance_transfer/balance_transfer_history/balance_transfer_history_view.dart';
import 'package:kaibo/pages/mine/assets/points_transfer/points_transfer_binding.dart';
import 'package:kaibo/pages/mine/assets/points_transfer/points_transfer_view.dart';
import 'package:kaibo/pages/mine/assets/points_transfer/points_transfer_history/points_transfer_history_binding.dart';
import 'package:kaibo/pages/mine/assets/points_transfer/points_transfer_history/points_transfer_history_view.dart';
import 'package:kaibo/pages/mine/assets/assets_binding.dart';
import 'package:kaibo/pages/mine/assets/assets_view.dart';
import 'package:kaibo/pages/mine/assets/wallet/wallet_binding.dart';
import 'package:kaibo/pages/mine/assets/wallet/wallet_view.dart';
import 'package:kaibo/pages/mine/orders/orders_binding.dart';
import 'package:kaibo/pages/mine/orders/orders_view.dart';
import 'package:kaibo/pages/mine/team/team_binding.dart';
import 'package:kaibo/pages/mine/team/team_view.dart';
import 'package:kaibo/pages/mine/invitation/invitation_binding.dart';
import 'package:kaibo/pages/mine/invitation/invitation_view.dart';
import 'package:kaibo/pages/mine/verification/verification_binding.dart';
import 'package:kaibo/pages/mine/verification/verification_view.dart';
import 'package:kaibo/pages/mine/cards/cards_binding.dart';
import 'package:kaibo/pages/mine/cards/cards_view.dart';
import 'package:kaibo/pages/mine/usdt/usdt_binding.dart';
import 'package:kaibo/pages/mine/usdt/usdt_view.dart';
import 'package:kaibo/pages/mine/points/points_binding.dart';
import 'package:kaibo/pages/mine/points/points_view.dart';
import 'package:kaibo/pages/mine/version/version_binding.dart';
import 'package:kaibo/pages/mine/version/version_view.dart';

// mine => user-settings
import 'package:kaibo/pages/mine/user_settings/modify_phone/modify_phone_binding.dart';
import 'package:kaibo/pages/mine/user_settings/modify_phone/modify_phone_view.dart';
import 'package:kaibo/pages/mine/user_settings/login_pwd/login_pwd_binding.dart';
import 'package:kaibo/pages/mine/user_settings/login_pwd/login_pwd_view.dart';
import 'package:kaibo/pages/mine/user_settings/billing_address/billing_address_binding.dart';
import 'package:kaibo/pages/mine/user_settings/billing_address/billing_address_view.dart';
import 'package:kaibo/pages/mine/user_settings/withdrawal_pwd/withdrawal_pwd_binding.dart';
import 'package:kaibo/pages/mine/user_settings/withdrawal_pwd/withdrawal_pwd_view.dart';

part 'app_routes.dart';

class AppPages {
  /// 左滑关闭页面用于android
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    // Splash
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    // home
    _pageBuilder(
      name: AppRoutes.home,
      page: () => IndexPage(),
      binding: IndexBinding(),
    ),
    // environment
    _pageBuilder(
      name: AppRoutes.notification,
      page: () => NoticePage(),
      binding: NoticeBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.news,
      page: () => NewsPage(),
      binding: NewsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.newsDetail,
      page: () => NewsDetailPage(),
      binding: NewsDetailBinding(),
    ),
    // explore
    _pageBuilder(
      name: AppRoutes.buyProduct,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    // mine
    _pageBuilder(
      name: AppRoutes.userSettings,
      page: () => UserSettingsPage(),
      binding: UserSettingsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userDeposit,
      page: () => DepositPage(),
      binding: DepositBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userDepositHistory,
      page: () => DepositHistoryPage(),
      binding: DepositHistoryBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userWithdrawal,
      page: () => WithdrawalPage(),
      binding: WithdrawalBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userWithdrawalHistory,
      page: () => WithdrawalHistoryPage(),
      binding: WithdrawalHistoryBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.pointsTransfer,
      page: () => PointsTransferPage(),
      binding: PointsTransferBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.pointsTransferHistory,
      page: () => PointsTransferHistoryPage(),
      binding: PointsTransferHistoryBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.balanceTransfer,
      page: () => BalanceTransferPage(),
      binding: BalanceTransferBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.balanceTransferHistory,
      page: () => BalanceTransferHistoryPage(),
      binding: BalanceTransferHistoryBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userAssets,
      page: () => AssetsPage(),
      binding: AssetsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.walletTransfer,
      page: () => WalletPage(),
      binding: WalletBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userOrders,
      page: () => OrdersPage(),
      binding: OrdersBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userTeam,
      page: () => TeamPage(),
      binding: TeamBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userInvitation,
      page: () => InvitationPage(),
      binding: InvitationBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userVerification,
      page: () => VerificationPage(),
      binding: VerificationBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userCards,
      page: () => CardsPage(),
      binding: CardsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userUsdt,
      page: () => UsdtPage(),
      binding: UsdtBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userPoints,
      page: () => PointsPage(),
      binding: PointsBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.userVersion,
      page: () => VersionPage(),
      binding: VersionBinding(),
    ),
    // mine => user-settings
    _pageBuilder(
      name: AppRoutes.modifyPhone,
      page: () => ModifyPhonePage(),
      binding: ModifyPhoneBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.modifyLoginPwd,
      page: () => LoginPwdPage(),
      binding: LoginPwdBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.modifyBillingAddr,
      page: () => BillingAddressPage(),
      binding: BillingAddressBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.modifyWithdrawalPwd,
      page: () => WithdrawalPwdPage(),
      binding: WithdrawalPwdBinding(),
    ),
  ];
}
