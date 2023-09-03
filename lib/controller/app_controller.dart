import 'dart:ui';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/utils/upgrade_manager.dart';

class AppController extends GetxController with UpgradeManger{
  var isRunningBackground = false;
  var backgroundSubject = PublishSubject<bool>();
  var isAppBadgeSupported = false;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
        ) async {},
  );

  final _ring = 'assets/audio/message_ring.wav';
  final _audioPlayer = AudioPlayer(
    // Handle audio_session events ourselves for the purpose of this demo.
    // handleInterruptions: false,
    // androidApplyAudioAttributes: false,
    // handleAudioSessionActivation: false,
  );

  late BaseDeviceInfo deviceInfo;

  final clientConfigMap = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    _requestPermissions();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {},
    );
    _startForegroundService();
    isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    super.onInit();
  }

  @override
  void onReady() {
    _startForegroundService();
    // _queryClientConfig();
    _getDeviceInfo();
    _cancelAllNotifications();
    // autoCheckVersionUpgrade();
    super.onReady();
  }

  @override
  void onClose() {
    backgroundSubject.close();
    // _stopForegroundService();
    closeSubject();
    _audioPlayer.dispose();
    super.onClose();
  }

  void runningBackground(bool run) {
    Logger.print('-----App running background : $run-------------');
    if (isRunningBackground && !run) {}
    isRunningBackground = run;
    backgroundSubject.sink.add(run);
    if (!run) {
      _cancelAllNotifications();
    }
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Future<void> showNotification(im.Message message) async {
  //   if (_isGlobalNotDisturb() ||
  //       message.attachedInfoElem?.notSenderNotificationPush == true ||
  //       message.contentType ==
  //           im.MessageType
  //               .typing /* ||
  //       message.contentType! >= 1000*/
  //   ) return;
  //
  //   // 开启免打扰的不提示
  //   var sourceID = message.sessionType == ConversationType.single
  //       ? message.sendID
  //       : message.groupID;
  //   if (sourceID != null && message.sessionType != null) {
  //     var i = await OpenIM.iMManager.conversationManager.getOneConversation(
  //       sourceID: sourceID,
  //       sessionType: message.sessionType!,
  //     );
  //     if (i.recvMsgOpt != 0) return;
  //   }
  //
  //   promptSoundOrNotification(message.seq!);
  // }
  //
  // Future<void> promptSoundOrNotification(int seq) async {
  //   if (!isRunningBackground) {
  //     _playMessageSound();
  //   } else {
  //     if (Platform.isAndroid) {
  //       final id = seq;
  //
  //       const androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //           'chat', 'OpenIM聊天消息',
  //           channelDescription: '来自OpenIM的信息',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //       const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //       await flutterLocalNotificationsPlugin.show(
  //           id, '您收到了一条新消息', '消息内容：.....', platformChannelSpecifics,
  //           payload: '');
  //     }
  //   }
  // }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _startForegroundService() async {
    await getAppInfo();
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'pro', 'OpenIM后台进程',
        channelDescription: '保证app能收到信息',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.startForegroundService(1, packageInfo!.appName, '正在运行...',
        notificationDetails: androidPlatformChannelSpecifics, payload: '');
  }
  //
  // Future<void> _stopForegroundService() async {
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.stopForegroundService();
  // }
  //
  // void showBadge(count) {
  //   if (isAppBadgeSupported) {
  //     if (count == 0) {
  //       removeBadge();
  //       PushController.resetBadge();
  //     } else {
  //       FlutterAppBadger.updateBadgeCount(count);
  //       PushController.setBadge(count);
  //     }
  //   }
  // }
  //
  // void removeBadge() {
  //   FlutterAppBadger.removeBadge();
  // }

  Locale? getLocale() {
    var local = Get.locale;
    var index = DataSp.getLanguage() ?? 0;
    switch (index) {
      case 1:
        local = const Locale('zh', 'CN');
        break;
      case 2:
        local = const Locale('en', 'US');
        break;
    }
    return local;
  }

  void _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfo = await deviceInfoPlugin.deviceInfo;
  }

  // void _queryClientConfig() async {
  //   final map = await Apis.getClientConfig();
  //   clientConfigMap.assignAll(map);
  // }
}