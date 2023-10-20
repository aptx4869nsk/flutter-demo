import 'config.dart';

class Urls {
  /// App更新检测
  static final checkVersion = "${Config.appApiUrl}/check-version";

  /// 获取验证码
  static var recaptcha = "${Config.appApiUrl}/get-recaptcha";

  /// 注册设置
  static var registerSettings = "${Config.appApiUrl}/register-settings";

  /// 登陆
  static var login = "${Config.appApiUrl}/login";

  ///  忘记密码
  static var forgotPwd = "${Config.appApiUrl}/forgot-password";

  ///  注册
  static var register = "${Config.appApiUrl}/register";

  ///  获取短信验证码 - OTP
  static var otp = "${Config.appApiUrl}/get-otp";

  ///  账户信息
  static var preload = "${Config.appApiUrl}/preload-data";

  /// 双碳行动
  /// 签到 check-in
  static var checkIn = "${Config.appApiUrl}/check-in";

  /// 获取新闻记录
  static var notices = "${Config.appApiUrl}/notifications";

  /// 获取新闻记录
  static var newsHistories = "${Config.appApiUrl}/get-news";

  /// 获取新闻详情
  static var newsDetail = "${Config.appApiUrl}/get-news/%s/detail";

  ///  美丽中国
  static var products = "${Config.appApiUrl}/products";

  ///  Buy - 美丽中国
  static var buyProduct = "${Config.appApiUrl}/products/%s/buy";

  ///  账户信息 - 我的
  static var profile = "${Config.appApiUrl}/profile";

  ///  充值地址
  static var depositAddress = "${Config.appApiUrl}/deposit-address";

  /// 修改密码
  static var changeLoginPwd = "${Config.appApiUrl}/change-password";

  /// 设置/修改提款（资金）密码
  static var changeWithdrawalPwd = "${Config.appApiUrl}/bind-withdraw-password";

  ///  充值
  static var deposit = "${Config.appApiUrl}/deposit";

  /// 支付凭据
  static var uploadPaidScreenshot =
      "${Config.appApiUrl}/dw-records/%s/upload-screenshot";

  /// 提现
  static var withdrawal = "${Config.appApiUrl}/withdraw";

  /// 充值/提现 记录
  static var depositWithdrawalRecords = "${Config.appApiUrl}/dw-histories";

  // 积分账户 - 获取用户名
  static var checkUserName = "${Config.appApiUrl}/check-user-name";

  // 积分账户 - 积分转账
  static var pointsTransfer = "${Config.appApiUrl}/transfer";

  // 积分账户 - 余额宝转账
  static var balanceTransfer = "${Config.appApiUrl}/transfer-score";

  /// 获取资产类型
  static var transactionTypes = "${Config.appApiUrl}/transaction-filters";

  /// 资金记录
  static var transactionHistories = "${Config.appApiUrl}/transaction-histories";

  /// 资金记录
  static var orderHistories = "${Config.appApiUrl}/order-histories";

  /// 余额兑换积分
  static var walletToPointsSwap = "${Config.appApiUrl}/wallet-transfer";

  /// 获取我的团队
  static var teams = "${Config.appApiUrl}/my-teams";

  /// 实名认证
  static var verification = "${Config.appApiUrl}/verify-card";

  /// 上传身份证
  static var uploadNrc = "${Config.appApiUrl}/upload-card";

  /// 获取银行
  static var supportedBanks = "${Config.appApiUrl}/banks";

  /// 绑定银行卡
  static var bindBankCard = "${Config.appApiUrl}/bind-bank";

  /// 绑定USDT
  static var bindUsdt = "${Config.appApiUrl}/bind-usdt";

  /// 绑定收获地址
  static var bindShippingAddress = "${Config.appApiUrl}/bind-shipping-address";
}
