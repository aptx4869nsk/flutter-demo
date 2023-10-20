import 'package:dio/dio.dart';
import 'package:kaibo/models/news_detail.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/utils/http_util.dart';
import 'package:kaibo/models/upgrade_info.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/models/login_certificate.dart';
import 'package:kaibo/models/preload.dart';
import 'package:kaibo/models/product.dart';
import 'package:kaibo/models/profile.dart';
import 'package:kaibo/models/deposit.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/models/supported_bank.dart';
import 'package:kaibo/models/transaction_types.dart';
import 'package:kaibo/models/notice.dart';
import 'package:kaibo/models/register_settings.dart';
import 'package:sprintf/sprintf.dart';

import 'models/team.dart';
import 'urls.dart';

class Apis {
  static Options get tokenOption =>
      Options(headers: {'Authorization': 'Bearer ${DataSp.userToken}'});

  // 版本更新
  static Future<UpgradeInfo> checkUpgrade() async {
    try {
      var data = await HttpUtil.get(Urls.checkVersion);
      return UpgradeInfo.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  // 获取验证码
  static Future<String> getRecaptcha() async {
    try {
      var resp = await HttpUtil.get(Urls.recaptcha);
      var code = resp['code'];
      return code;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  // 注册设置
  static Future<RegisterSettings> getRegisterSettings() async {
    try {
      var data = await HttpUtil.get(Urls.registerSettings);
      return RegisterSettings.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// login
  static Future<LoginCertificate> login({
    String? phone,
    String? password,
    String? recaptcha,
  }) async {
    try {
      var data = await HttpUtil.post(Urls.login, data: {
        "phone": phone,
        'password': password,
        'recaptcha': recaptcha,
      });
      return LoginCertificate.fromJson(data!);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// register
  static Future<bool> register({
    String? name,
    String? phone,
    String? password,
    String? inviteCode,
    String? otp,
  }) async {
    try {
      await HttpUtil.post(Urls.register, data: {
        'name': name,
        "phone": phone,
        'password': password,
        'invite_code': inviteCode,
        'otp': otp,
      });
      return true;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  // 获取短信验证码
  static Future<bool> getOtp({required String phone}) async {
    try {
      await HttpUtil.post(Urls.otp, data: {
        'phone': phone,
      });
      return true;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// Preload - 初始化
  static Future<Preload> preload() async {
    try {
      var data = await HttpUtil.get(
        Urls.preload,
        options: tokenOption,
      );
      return Preload.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 双碳行动
  /// 签到
  static Future<bool> checkIn() async {
    try {
      await HttpUtil.post(
        Urls.checkIn,
        options: tokenOption,
        showSuccessToast: false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 获取公告
  static Future<Notices> getNotices({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.notices,
        queryParameters: {
          'page': page,
          'perPage': pageSize ?? '5',
        },
        options: tokenOption,
      );
      return Notices.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取新闻记录
  static Future<NewsHistories> getNewsHistories({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.newsHistories,
        queryParameters: {
          'page': page,
          'perPage': pageSize ?? '5',
        },
        options: tokenOption,
      );
      return NewsHistories.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取新闻详情
  static Future<NewsDetail> getNewsDetail({
    required int newsId,
  }) async {
    try {
      String url = sprintf(Urls.newsDetail, [newsId]);
      var data = await HttpUtil.get(
        url,
        options: tokenOption,
      );
      return NewsDetail.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 美丽中国
  /// Product
  static Future<Products> products({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.products,
        queryParameters: {
          'page': page ?? 1,
          'perPage': pageSize ?? '10',
        },
        options: tokenOption,
      );
      return Products.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// Buy Product - 美丽中国
  static Future<bool> buyProduct({
    required int productId,
    required String amount,
  }) async {
    try {
      String url = sprintf(Urls.buyProduct, [productId]);
      await HttpUtil.post(
        url,
        data: {
          'amount': amount,
        },
        options: tokenOption,
      );
      return true;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// Profile - 我的
  static Future<Profile> profile() async {
    try {
      var data = await HttpUtil.get(
        Urls.profile,
        options: tokenOption,
      );
      return Profile.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取充值地址
  static Future<DepositAddress> depositAddress() async {
    try {
      var data = await HttpUtil.get(
        Urls.depositAddress,
        options: tokenOption,
      );
      return DepositAddress.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 修改密码
  static Future<bool> changeLoginPwd({
    required String oldPwd,
    required String newPwd,
  }) async {
    try {
      await HttpUtil.post(
        Urls.changeLoginPwd,
        data: {
          "old_password": oldPwd,
          'new_password': newPwd,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 设置提款（资金）密码
  static Future<bool> setWithdrawalPwd({
    required String pwd,
  }) async {
    try {
      await HttpUtil.post(
        Urls.changeWithdrawalPwd,
        data: {
          "password": pwd,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 修改提款（资金）密码
  static Future<bool> changeWithdrawalPwd({
    required String oldPwd,
    required String newPwd,
  }) async {
    try {
      await HttpUtil.post(
        Urls.changeWithdrawalPwd,
        data: {
          "password": newPwd,
          'old_password': oldPwd,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 充值
  static Future<String> deposit({
    required int currency,
    required String amount,
  }) async {
    try {
      var data = await HttpUtil.post(
        Urls.deposit,
        data: {
          'currency': currency,
          'amount': amount,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return data['id'].toString();
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 上传支付凭据
  static Future<bool> uploadPaidScreenshot({
    required String transactionId,
    required String path,
  }) async {
    try {
      String url = sprintf(Urls.uploadPaidScreenshot, [transactionId]);
      await HttpUtil.uploadImage(url, path: path);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 提现
  static Future<bool> withdrawal({
    required int currency,
    required String amount,
    required String password,
  }) async {
    try {
      await HttpUtil.post(
        Urls.withdrawal,
        data: {
          'currency': currency,
          'amount': amount,
          'password': password,
        },
        options: tokenOption,
      );
      return true;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 充值记录
  static Future<DepositWithdrawalHistories> depositHistories({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.depositWithdrawalRecords,
        queryParameters: {
          'type': 1,
          'page': page,
          'perPage': pageSize ?? '10',
        },
        options: tokenOption,
      );
      return DepositWithdrawalHistories.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 提现记录
  static Future<DepositWithdrawalHistories> withdrawalHistories({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.depositWithdrawalRecords,
        queryParameters: {
          'type': 2,
          'page': page,
          'perPage': pageSize ?? '10',
        },
        options: tokenOption,
      );
      return DepositWithdrawalHistories.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 转账 - 获取用户名
  static Future<String> checkName({
    String? phone,
  }) async {
    try {
      var data = await HttpUtil.post(
        Urls.checkUserName,
        data: {
          "phone": phone,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return data['name'];
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 转账 - 积分转账
  static Future<bool> transferPoints({
    String? phone,
    String? amount,
    String? pwd,
  }) async {
    try {
      await HttpUtil.post(
        Urls.pointsTransfer,
        data: {
          "phone": phone,
          "amount": amount,
          "password": pwd,
        },
        options: tokenOption,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 转账 - 余额宝转账
  static Future<bool> transferBalance({
    String? phone,
    String? amount,
    String? pwd,
  }) async {
    try {
      await HttpUtil.post(
        Urls.balanceTransfer,
        data: {
          "phone": phone,
          "amount": amount,
          "password": pwd,
        },
        options: tokenOption,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 获取资产类型
  static Future<TransactionTypes> getTransactionTypes() async {
    try {
      var data = await HttpUtil.get(
        Urls.transactionTypes,
        options: tokenOption,
      );
      return TransactionTypes.fromJson({
        'types': data,
      });
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取资金记录
  /// 000-投资收益 001-收入 002-转出 003-购买产品 004-强制结束 005-签到 006-余额兑换积分 007-订单结束
  static Future<TransactionHistories> getTransactionHistories({
    int? page,
    int? pageSize,
    String? code,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.transactionHistories,
        queryParameters: {
          'page': page,
          'perPage': pageSize ?? '10',
          'code': code ?? '',
        },
        options: tokenOption,
      );
      return TransactionHistories.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  // 余额兑换积分
  static Future<bool> walletToPointsSwap({
    required String amount,
    required String password,
  }) async {
    try {
      await HttpUtil.post(
        Urls.walletToPointsSwap,
        data: {
          'amount': amount,
          'password': password,
        },
        options: tokenOption,
      );
      return true;
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取购买订单记录
  static Future<OrderHistories> getOrderHistories({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.orderHistories,
        queryParameters: {
          'page': page,
          'perPage': pageSize ?? '10',
        },
        options: tokenOption,
      );
      return OrderHistories.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 获取我的团队
  static Future<Teams> getTeams({
    int? page,
    int? pageSize,
  }) async {
    try {
      var data = await HttpUtil.get(
        Urls.teams,
        queryParameters: {
          'page': page,
          'perPage': pageSize ?? '10',
        },
        options: tokenOption,
      );
      return Teams.fromJson(data);
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 实名认证
  static Future<bool> realNameVerification({
    String? realName,
    String? nrcNbr,
  }) async {
    try {
      await HttpUtil.post(
        Urls.verification,
        data: {
          "card_name": realName,
          'card_number': nrcNbr,
        },
        options: tokenOption,
        showSuccessToast: false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Upload NRC Image
  static Future<bool> uploadNrc({
    required String type,
    required String path,
  }) async {
    try {
      return await HttpUtil.uploadImage(Urls.uploadNrc,
          path: path,
          queryParameters: {
            'type': type,
          });
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 获取银行
  static Future<SupportedBanks> getBanks() async {
    try {
      var data = await HttpUtil.get(
        Urls.supportedBanks,
        options: tokenOption,
      );
      return SupportedBanks.fromJson({
        'banks': data,
      });
    } catch (e, s) {
      Logger.print('e:$e s:$s');
      return Future.error(e);
    }
  }

  /// 绑定银行卡
  static Future<bool> bindBankCard({
    required String bankName,
    required String bankBranch,
    required String bankAccNbr,
    required String bankCode,
    required String holderName,
  }) async {
    try {
      await HttpUtil.post(
        Urls.bindBankCard,
        data: {
          "bank_code": bankCode,
          "bank_name": bankName,
          "bank_address": bankBranch,
          "bank_card_name": holderName,
          "bank_card_number": bankAccNbr,
        },
        options: tokenOption,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 绑定USDT
  static Future<bool> bindUsdt({
    String? usdtAddress,
    String? bscAddress,
  }) async {
    try {
      if ((usdtAddress ?? '').isNotEmpty && (bscAddress ?? '').isNotEmpty) {
        await HttpUtil.post(
          Urls.bindUsdt,
          data: {
            "trc_address": usdtAddress,
            "bsc_address": bscAddress,
          },
          options: tokenOption,
        );
      } else if ((usdtAddress ?? '').isNotEmpty) {
        await HttpUtil.post(
          Urls.bindUsdt,
          data: {
            "trc_address": usdtAddress,
          },
          options: tokenOption,
        );
      } else {
        await HttpUtil.post(
          Urls.bindUsdt,
          data: {
            "bsc_address": bscAddress,
          },
          options: tokenOption,
        );
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // /// 绑定BSC
  // static Future<bool> bindBsc({
  //   required String bscAddress,
  // }) async {
  //   try {
  //     await HttpUtil.post(
  //       Urls.bindUsdt,
  //       data: {
  //         "bsc_address": bscAddress,
  //       },
  //       options: tokenOption,
  //     );
  //     return true;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  /// 绑定收获地址
  static Future<bool> bindShippingAddress({
    required String address,
    required String phone,
  }) async {
    try {
      await HttpUtil.post(
        Urls.bindShippingAddress,
        data: {
          "address": address,
          "shipping_phone": phone,
        },
        options: tokenOption,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
