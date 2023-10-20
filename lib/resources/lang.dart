import 'dart:ui';

import 'package:get/get.dart';

import 'package:kaibo/lang/en_us.dart';
import 'package:kaibo/lang/zh_cn.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'zh_CN': zhCN,
      };
}

class Globe {
  Globe._();

  // splash
  static String get welcome => 'welcome'.tr;

  // auth
  static String get login => 'login'.tr;

  static String get pwd => 'pwd'.tr;

  static String get plsEnterPwd => 'plsEnterPwd'.tr;

  static String get recaptcha => 'recaptcha'.tr;

  static String get plsEnterRecaptcha => 'plsEnterRecaptcha'.tr;

  static String get getRecaptcha => 'getRecaptcha'.tr;

  static String get haveNoAcc => 'haveNoAcc'.tr;

  static String get register => 'register'.tr;

  static String get canNotRegister => 'canNotRegister'.tr;

  static String get name => 'name'.tr;

  static String get plsEnterName => 'plsEnterName'.tr;

  static String get phone => 'phone'.tr;

  static String get plsEnterPhone => 'plsEnterPhone'.tr;

  static String get otp => 'otp'.tr;

  static String get plsEnterOtp => 'plsEnterOtp'.tr;

  static String get invitationCode => 'invitationCode'.tr;

  static String get plsEnterInvitationCode => 'plsEnterInvitationCode'.tr;

  static String get alreadyHaveAcc => 'alreadyHaveAcc'.tr;

  // bottom-nav-bar
  static String get home => 'home'.tr;

  static String get market => 'market'.tr;

  static String get environment => 'environment'.tr;

  static String get explore => 'explore'.tr;

  static String get mine => 'mine'.tr;

  // toast
  static String get copySuccessfully => 'copySuccessfully'.tr;

  static String get savedToGallery => 'savedToGallery'.tr;

  // register
  static String get nickName => 'nickName'.tr;

  static String get plsEnterNickName => 'plsEnterNickName'.tr;

  static String get verificationCode => 'verificationCode'.tr;

  static String get sendVerificationCode => 'sendVerificationCode'.tr;

  static String get resendVerificationCode => 'resendVerificationCode'.tr;

  static String get verificationCodeTimingReminder =>
      'verificationCodeTimingReminder'.tr;

  static String get plsEnterRightPhone => 'plsEnterRightPhone'.tr;

  // login
  static String get phoneNumber => 'phoneNumber'.tr;

  static String get plsEnterPhoneNumber => 'plsEnterPhoneNumber'.tr;

  static String get password => 'password'.tr;

  static String get plsEnterPassword => 'plsEnterPassword'.tr;

  static String get confirmPassword => 'confirmPassword'.tr;

  static String get plsEnterConfirmPassword => 'plsEnterConfirmPassword'.tr;

  static String get account => 'account'.tr;

  static String get plsEnterAccount => 'plsEnterAccount'.tr;

  // buttons
  static String get confirm => 'confirm'.tr;

  static String get cancel => 'cancel'.tr;

  static String get copy => 'copy'.tr;

  static String get refresh => 'refresh'.tr;

  static String get close => 'close'.tr;

  static String get edit => 'edit'.tr;

  // update manager
  static String get downloading => 'downloading'.tr;

  static String get downloadFailed => 'downloadFailed'.tr;

  // upgrade view
  static String get upgradeFind => 'upgradeFind'.tr;

  static String get upgradeVersion => 'upgradeVersion'.tr;

  static String get upgradeDescription => 'upgradeDescription'.tr;

  static String get upgradeIgnore => 'upgradeIgnore'.tr;

  static String get upgradeLater => 'upgradeLater'.tr;

  static String get upgradeNow => 'upgradeNow'.tr;

  // info
  static String get comingSoon => 'comingSoon'.tr;

  static String get pending => 'pending'.tr;

  static String get success => 'success'.tr;

  static String get failed => 'failed'.tr;

  static String get rejected => 'rejected'.tr;

  static String get loadStatusIdle => 'loadStatusIdle'.tr;

  static String get loadStatusLoading => 'loadStatusLoading'.tr;

  static String get loadStatusFailed => 'loadStatusFailed'.tr;

  static String get loadStatusCanLoading => 'loadStatusCanLoading'.tr;

  static String get loadStatusNoMore => 'loadStatusNoMore'.tr;

  static String get reqSuccess => 'reqSuccess'.tr;

  static String get verificationReqSuccess => 'verificationReqSuccess'.tr;

  static String get nrcUploadFailed => "nrcUploadFailed".tr;

  static String get networkImgLoadFailed => "networkImgLoadFailed".tr;

  static String get unknownOss => "unknownOss".tr;

  static String get plsSetWithdrawalPwd => "plsSetWithdrawalPwd".tr;

  static String get plsVerifiedAcc => 'plsVerifiedAcc'.tr;

  static String get checkInSuccess => 'checkInSuccess'.tr;

  static String get appAlreadyLatestVersion => 'appAlreadyLatestVersion'.tr;

  // environment
  static String get checkin => 'checkin'.tr;

  static String get notification => 'notification'.tr;

  static String get notificationDetail => 'notificationDetail'.tr;

  static String get news => 'news'.tr;

  static String get newsDetail => 'newsDetail'.tr;

  static String get newsMore => 'newsMore'.tr;

  static String get detail => 'detail'.tr;

  // explore
  static String get product => 'product'.tr;

  static String get productName => 'productName'.tr;

  static String get earnRate => 'earnRate'.tr;

  static String get minBuy => 'minBuy'.tr;

  static String get maxBuy => 'maxBuy'.tr;

  static String get duration => 'duration'.tr;

  static String get durationDays => 'durationDays'.tr;

  static String get buyNow => 'buyNow'.tr;

  static String get denyBuy => 'denyBuy'.tr;

  static String get buyProductTime => 'buyProductTime'.tr;

  // buy product -- explore
  static String get productDetails => 'productDetails'.tr;

  // mine
  static String get userAccount => 'userAccount'.tr;

  static String get points => 'points'.tr;

  static String get balance => 'balance'.tr;

  static String get userDeposit => 'userDeposit'.tr;

  static String get userWithdrawal => 'userWithdrawal'.tr;

  static String get myAssets => 'myAssets'.tr;

  static String get myOrders => 'myOrders'.tr;

  static String get myTeam => 'myTeam'.tr;

  static String get myInvitation => 'myInvitation'.tr;

  static String get myVerification => 'myVerification'.tr;

  static String get myCards => 'myCards'.tr;

  static String get myUsdt => 'myUsdt'.tr;

  static String get myPoints => 'myPoints'.tr;

  static String get myVersion => 'myVersion'.tr;

  // mine => user-assets => transfer
  static String get userTransfer => 'userTransfer'.tr;

  static String get pointsTransfer => 'pointsTransfer'.tr;

  static String get balanceTransfer => 'balanceTransfer'.tr;

  // mine => user-settings
  static String get userSettings => 'userSettings'.tr;

  static String get modifyPhone => 'modifyPhone'.tr;

  static String get modifyLoginPwd => 'modifyLoginPwd'.tr;

  static String get modifyShippingAddr => 'modifyShippingAddr'.tr;

  static String get setWithdrawalPwd => 'setWithdrawalPwd'.tr;

  static String get modifyWithdrawalPwd => 'modifyWithdrawalPwd'.tr;

  static String get safetyLogout => 'safetyLogout'.tr;

  static String get logoutHint => 'logoutHint'.tr;

  // user-settings => modify-phone
  static String get withdrawalPwd => 'withdrawalPwd'.tr;

  static String get plsEnterWithdrawalPwd => 'plsEnterWithdrawalPwd'.tr;

  // user-settings => modify-login-pwd
  static String get newPwd => 'newPwd'.tr;

  static String get plsEnterNewPwd => 'plsEnterNewPwd'.tr;

  static String get confirmNewPwd => 'confirmNewPwd'.tr;

  static String get plsEnterConfirmNewPwd => 'plsEnterConfirmNewPwd'.tr;

  static String get oldPwd => 'oldPwd'.tr;

  static String get plsEnterOldPwd => 'plsEnterOldPwd'.tr;

  static String get pwdNotMatch => 'pwdNotMatch'.tr;

  // user-settings => modify-billing-address
  static String get shippingPhone => 'shippingPhone'.tr;

  static String get plsEnterShippingPhone => 'plsEnterShippingPhone'.tr;

  static String get shippingAddr => 'shippingAddr'.tr;

  static String get plsEnterShippingAddr => 'plsEnterShippingAddr'.tr;

  // mine => deposit
  static String get history => 'history'.tr;

  static String get depositHistory => 'depositHistory'.tr;

  static String get depositAmt => 'depositAmt'.tr;

  static String get plsEnterDepositAmt => 'plsEnterDepositAmt'.tr;

  static String get usdt => 'usdt'.tr;

  static String get bsc => 'bsc'.tr;

  static String get rmb => 'rmb'.tr;

  static String get depositType => 'depositType'.tr;

  static String get paidScreenshot => 'paidScreenshot'.tr;

  static String get bankName => 'bankName'.tr;

  static String get bankAccNbr => 'bankAccNbr'.tr;

  static String get bankBranch => 'bankBranch'.tr;

  static String get holderName => 'holderName'.tr;

  static String get plsUploadPaidScreenshot => 'plsUploadPaidScreenshot'.tr;

  static String get depositReqSuccess => 'depositReqSuccess'.tr;

  static String get minDepositAmt => 'minDepositAmt'.tr;

  static String get maxDepositAmt => 'maxDepositAmt'.tr;

  static String get depositTime => 'depositTime'.tr;

  static String get canNotDepositNow => 'canNotDepositNow'.tr;

  static String get canNotTransfer => 'canNotTransfer'.tr;

  // mine => withdrawal
  static String get withdrawalHistory => 'withdrawalHistory'.tr;

  static String get withdrawalReqSuccess => 'withdrawalReqSuccess'.tr;

  static String get minWithdrawalAmt => 'minWithdrawalAmt'.tr;

  static String get maxWithdrawalAmt => 'maxWithdrawalAmt'.tr;

  static String get withdrawalTime => 'withdrawalTime'.tr;

  // mine => transfer
  static String get transferAmt => 'transferAmt'.tr;

  static String get transferHistory => 'transferHistory'.tr;

  static String get plsEnterTransferAmt => 'plsEnterTransferAmt'.tr;

  static String get transferToAcc => 'transferToAcc'.tr;

  static String get plsEnterTransferToAcc => 'plsEnterTransferToAcc'.tr;

  static String get plsEnterValidTransferAcc => 'plsEnterValidTransferAcc'.tr;

  static String get transferAccName => 'transferAccName'.tr;

  static String get remainingPoints => 'remainingPoints'.tr;

  static String get remainingBalance => 'remainingBalance'.tr;

  static String get notEnoughPoints => 'notEnoughPoints'.tr;

  static String get notEnoughBalance => 'notEnoughBalance'.tr;

  // transfer-history
  static String get transferIn => 'transferIn'.tr;

  static String get transferOut => 'transferOut'.tr;

  static String get transferInAcc => 'transferInAcc'.tr;

  static String get transferInAccName => 'transferInAccName'.tr;

  static String get transferOutAcc => 'transferOutAcc'.tr;

  static String get transferOutAccName => 'transferOutAccName'.tr;

  // mine => assets
  static String get balanceToPoints => 'balanceToPoints'.tr;

  static String get assetsLog => 'assetsLog'.tr;

  static String get all => 'all'.tr;

  static String get checkIn => 'checkIn'.tr;

  static String get investProfit => 'investProfit'.tr;

  static String get teamProfit => 'teamProfit'.tr;

  static String get swapProfit => 'swapProfit'.tr;

  static String get wageProfit => 'wageProfit'.tr;

  static String get subOrdinateProfit => 'subOrdinateProfit'.tr;

  static String get pointsToBalance => 'pointsToBalance'.tr;

  // assets => wallet-transfer
  static String get walletTransferAmt => 'walletTransferAmt'.tr;

  static String get plsEnterWalletTransferAmt => 'plsEnterWalletTransferAmt'.tr;

  // mine => orders
  static String get myOrder => 'myOrder'.tr;

  static String get myProductName => 'myProductName'.tr;

  static String get interestRate => 'interestRate'.tr;

  static String get orderInterestRate => 'orderInterestRate'.tr;

  static String get startDate => 'startDate'.tr;

  static String get remainingDate => 'remainingDate'.tr;

  static String get orderRemainingDate => 'orderRemainingDate'.tr;

  static String get orderStatus => 'orderStatus'.tr;

  static String get orderStatusNormal => 'orderStatusNormal'.tr;

  static String get orderStatusEnd => 'orderStatusEnd'.tr;

  static String get orderStatusForcedEnd => 'orderStatusForcedEnd'.tr;

  static String get orderPrice => 'orderPrice'.tr;

  // mine => team
  static String get teamSpendAmt => 'teamSpendAmt'.tr;

  static String get teamMembersCount => 'teamMembersCount'.tr;

  static String get memberName => 'memberName'.tr;

  // mine => invitation
  static String get longPressToSaveQrCode => 'longPressToSaveQrCode'.tr;

  static String get copyAppDownloadLink => 'copyAppDownloadLink'.tr;

  // mine => verification
  static String get realName => 'realName'.tr;

  static String get plsEnterRealName => 'plsEnterRealName'.tr;

  static String get nrcNbr => 'nrcNbr'.tr;

  static String get plsEnterNrcNbr => 'plsEnterNrcNbr'.tr;

  static String get uploadNRC => 'uploadNRC'.tr;

  static String get plsUploadNrcFront => 'plsUploadNrcFront'.tr;

  static String get plsUploadNrcBack => 'plsUploadNrcBack'.tr;

  // mine => cards
  static String get plsSelectBankName => 'plsSelectBankName'.tr;

  static String get plsEnterBankAccNbr => 'plsEnterBankAccNbr'.tr;

  static String get plsEnterValidBankAccNbr => 'plsEnterValidBankAccNbr'.tr;

  static String get plsEnterBankBranch => 'plsEnterBankBranch'.tr;

  static String get plsEnterHolderName => 'plsEnterHolderName'.tr;

  static String get plsEnterValidHolderName => 'plsEnterValidHolderName'.tr;

  // mine => usdt
  static String get usdtAddr => 'usdtAddr'.tr;

  static String get plsEnterUsdtAddr => 'plsEnterUsdtAddr'.tr;

  static String get bscAddr => 'bscAddr'.tr;

  static String get plsEnterBscAddr => 'plsEnterBscAddr'.tr;

  static String get plsEnterBindAddr => 'plsEnterBindAddr'.tr;

  // mine => points
  static String get pointsCount => 'pointsCount'.tr;

  static String get swapPoints => 'swapPoints'.tr;

  static String get sellOutPoints => 'sellOutPoints'.tr;

  static String get checkInNot180Days => 'checkInNot180Days'.tr;

  static String get haveNoPoints => 'haveNoPoints'.tr;

  // mine => version
  static String get currentVersion => 'currentVersion'.tr;

  static String get upgradeVersionTitle => 'upgradeVersionTitle'.tr;

  static String get upgradeVersionDescription => 'upgradeVersionDescription'.tr;

  static String get upgradeApp => 'upgradeApp'.tr;
}
