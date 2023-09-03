import 'package:dio/dio.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/utils/http_util.dart';
import 'package:kaibo/models/upgrade_info.dart';
import 'package:kaibo/utils/logger.dart';
import 'urls.dart';

class Apis {
  static Options get userTokenOptions =>
      Options(headers: {'token': DataSp.userToken});

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
}
