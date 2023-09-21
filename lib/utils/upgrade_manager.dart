import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mini_store/apis.dart';
import 'package:mini_store/views/upgrade_view.dart';
import 'package:mini_store/views/loading_view.dart';
import 'package:mini_store/models/upgrade_info.dart';
import 'package:mini_store/resources/lang.dart';
import 'package:mini_store/widgets/app_widget.dart';
import 'data_sp.dart';
import 'permissions.dart';
import 'http_util.dart';
import 'app_utils.dart';

mixin class UpgradeManger {
  PackageInfo? packageInfo;
  UpgradeInfo? upgradeInfo;
  var isShowUpgradeDialog = false;
  var isNowIgnoreUpdate = false;
  final subject = PublishSubject<double>();

  void closeSubject() {
    subject.close();
  }

  void ignoreUpdate() {
    DataSp.putIgnoreVersion(upgradeInfo!.buildVersion!);
    Get.back();
  }

  void laterUpdate() {
    isNowIgnoreUpdate = true;
    Get.back();
  }

  getAppInfo() async {
    packageInfo ??= await PackageInfo.fromPlatform();
  }

  void nowUpdate() async {
    if (Platform.isAndroid) {
      Permissions.storage(() async {
        var path = await AppUtils.createTempFile(
          dir: 'apk',
          name: '${packageInfo!.appName}.apk',
        );
        NotificationService notificationService = NotificationService();
        HttpUtil.download(
          upgradeInfo!.apkDownloadLink!,
          cachePath: path,
          onProgress: (int count, int total) {
            subject.add(count / total);
            notificationService.createNotification(
                100, ((count / total) * 100).toInt(), 0, Globe.downloading);
            if (count == total) {
              AppInstaller.installApk(path);
            }
          },
        ).catchError((s, t) {
          notificationService.createNotification(
              100, 0, 0, Globe.downloadFailed);
        });
      });
    } else {
      // if (await canLaunch(upgradeInfo!.url!)) {
      //   launch(upgradeInfo!.url!);
      // }
    }
  }

  void checkUpdate() async {
    if (!Platform.isAndroid) return;
    LoadingView.singleton.wrap(asyncFunction: () async {
      await getAppInfo();
      return Apis.checkUpgrade();
    }).then((value) {
      upgradeInfo = value;
      if (!canUpdate) {
        AppWidget.showToast('');
        return;
      }
      Get.dialog(
        UpgradeViewV2(
          upgradeInfo: upgradeInfo!,
          packageInfo: packageInfo!,
          onNow: nowUpdate,
          subject: subject,
        ),
        routeSettings: const RouteSettings(name: 'upgrade_dialog'),
      );
    });
  }

  /// 自动检测更新
  autoCheckVersionUpgrade() async {
    if (!Platform.isAndroid) return;
    if (isShowUpgradeDialog || isNowIgnoreUpdate) return;
    await getAppInfo();
    upgradeInfo = await Apis.checkUpgrade();
    String? ignore = DataSp.getIgnoreVersion();
    if (ignore == upgradeInfo!.buildVersion) {
      isNowIgnoreUpdate = true;
      return;
    }
    if (!canUpdate) return;
    isShowUpgradeDialog = true;
    Get.dialog(
      UpgradeViewV2(
        upgradeInfo: upgradeInfo!,
        packageInfo: packageInfo!,
        onLater: laterUpdate,
        onIgnore: ignoreUpdate,
        onNow: nowUpdate,
        subject: subject,
      ),
      routeSettings: const RouteSettings(name: 'upgrade_dialog'),
    ).whenComplete(() => isShowUpgradeDialog = false);
  }

  bool get canUpdate =>
      AppUtils.compareVersion(
        packageInfo!.version,
        upgradeInfo!.buildVersion!,
      ) <
      0;
}

class NotificationService {
  // Handle displaying of notifications.
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i, int id, String status) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'progress channel', 'progress channel',
        channelDescription: 'progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: count,
        progress: i);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin
        .show(id, status, '$i%', platformChannelSpecifics, payload: 'item x');
  }
}
