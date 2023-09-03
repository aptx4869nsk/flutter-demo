import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/utils/http_util.dart';
import 'package:kaibo/utils/logger.dart';

class Config {
  //初始化全局信息
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cachePath = (await getApplicationDocumentsDirectory()).path;
      await DataSp.init();
      await Hive.initFlutter(cachePath);
      HttpUtil.init();
    } catch (_) {}
    // initializeServer(); // <--- temp close for testing
    runApp();

    // 设置屏幕方向
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // 状态栏透明（Android）
    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

  }

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  /// 全局字体size
  static const double textScaleFactor = 1.0;

  // 测试服
  // http://api.lkjh6.com
  static const _host = "api.blocxpro.com";
  static const _port ="";

  static const _ipRegex =
      '((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)';

  static bool get _isIP => RegExp(_ipRegex).hasMatch(_host);

  // aliyun oss
  static const baseUrl = 'https://xinsannong.oss-cn-hongkong.aliyuncs.com';

  /// initialize Server
  static void initializeServer() async {
    final response = await dio.get('$baseUrl/base-url.json');
    if(response.statusCode == 200) {
      await DataSp.putServerConfig(response.data);
    } else {
      var data = {
        "baseUrl": "http://api.lkjh6.com",
      };
      await DataSp.putServerConfig(data);
    }
  }

  /// 服务器IP
  static String get serverIp {
    String? ip;
    var server = DataSp.getServerConfig();
    if (null != server) {
      ip = server['serverIP'];
      Logger.print('缓存serverIP: $ip');
    }
    return ip ?? _host;
  }


  /// App Api API
  static String get appApiUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if(server != null) {
      url = "${server['baseUrl']}/api";
      Logger.print('缓存apiUrl: $url');
    }
    return url ?? (_isIP ? 'http://$_host:$_port' : "https://$_host/api");
  }
}