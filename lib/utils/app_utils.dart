import 'dart:io';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

/// 间隔时间完成某事
class IntervalDo {
  DateTime? last;

  void run({required Function() fuc, int milliseconds = 0}) {
    DateTime now = DateTime.now();
    if (null == last ||
        now.difference(last ?? now).inMilliseconds > milliseconds) {
      last = now;
      fuc();
    }
  }
}

class AppUtils {
  AppUtils._();

  static void copy({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    AppWidget.showToast(Globe.copySuccessfully);
  }

  static List<T> toList<T>(
          String value, T Function(Map<String, dynamic> map) f) =>
      (formatJson(value) as List).map((e) => f(e)).toList();

  static dynamic formatJson(String value) => jsonDecode(value);

  static T toObj<T>(String value, T Function(Map<String, dynamic> map) f) =>
      f(formatJson(value));

  static List<dynamic> toListMap(String value) => formatJson(value);

  static Future<String> createTempFile({
    required String dir,
    required String fileName,
  }) async {
    // var path = (Platform.isIOS
    //         ? await getTemporaryDirectory()
    //         : await getExternalStorageDirectory())
    //     ?.path;
    var path = (Platform.isIOS
        ? await getTemporaryDirectory()
        : await getDownloadsDirectory())
        ?.path;
    File file = File('$path/$dir/$fileName');
    if (!(await file.exists())) {
      file.create(recursive: true);
    }
    return '$path/$dir/$fileName';
  }

  static int compareVersion(String val1, String val2) {
    var arr1 = val1.split(".");
    var arr2 = val2.split(".");
    int length = arr1.length >= arr2.length ? arr1.length : arr2.length;
    int diff = 0;
    int v1;
    int v2;
    for (int i = 0; i < length; i++) {
      v1 = i < arr1.length ? int.parse(arr1[i]) : 0;
      v2 = i < arr2.length ? int.parse(arr2[i]) : 0;
      diff = v1 - v2;
      if (diff == 0) {
        continue;
      } else {
        return diff > 0 ? 1 : -1;
      }
    }
    return diff;
  }

  static Future<String> getCacheFileDir() async {
    return (await getTemporaryDirectory()).absolute.path;
  }

  static bool isUrlValid(String? url) {
    if (null == url || url.isEmpty) {
      return false;
    }
    return url.startsWith("http://") || url.startsWith("https://");
  }

  static bool isValidUrl(String? urlString) {
    if (null == urlString || urlString.isEmpty) {
      return false;
    }
    Uri? uri = Uri.tryParse(urlString);
    if (uri != null && uri.hasScheme && uri.hasAuthority) {
      return true;
    }
    return false;
  }

  static String formatDateTime(String dateTime, {bool isZh = false}) {
    return DateUtil.formatDate(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(dateTime).millisecondsSinceEpoch,
      ),
      format: "yyyy-MM-dd HH:mm:ss",
    );
  }

  static String formatDate(String dateTime, {bool isZh = false}) {
    return DateUtil.formatDate(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(dateTime).millisecondsSinceEpoch,
      ),
      format: "yyyy-MM-dd",
    );
  }

  static int remainingDays(String endTime, {bool isZh = false}) {
    final today = DateTime.now();
    final endTimeStr = DateUtil.formatDate(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(endTime).millisecondsSinceEpoch,
      ),
      format: "yyyy-MM-dd",
    );
    final endDate = DateTime.parse(endTimeStr);

    // 设置时间部分为 00:00:00
    final todayWithoutTime = DateTime(today.year, today.month, today.day);
    final endDateWithoutTime =
        DateTime(endDate.year, endDate.month, endDate.day);
    // 计算天数，包括周末
    final difference = endDateWithoutTime.difference(todayWithoutTime);
    final totalDays = difference.inDays;
    // 计算排除周末后的天数
    int remainingDays = 0;
    // 2023-10-02 - 2024-07-28
    // 100 => 2024-feb-16
    // 100 => 2024-july-5
    // 100 => 2024-Nov-22
    // 25 => 2024-07-28
    // 15 => 2024-07-26
    // 2023-10-02 2024-11-25
    for (int i = 0; i <= totalDays; i++) {
      final currentDate = todayWithoutTime.add(Duration(days: i));
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday) {
        remainingDays++;
      }
    }
    // 计算天数
    // final difference = endDateWithoutTime.difference(todayWithoutTime);
    // final remainingDays = difference.inDays;
    if (remainingDays < 1) return 0;

    // 判断今日是否是周末
    if (today.weekday == DateTime.saturday || today.weekday == DateTime.sunday) {
      return remainingDays;
    } else {
      return remainingDays - 1;
    }
  }

  static bool isChineseName(String text) {
    final chineseRegExp = RegExp(r'^[\u4e00-\u9fa5]+$');
    return chineseRegExp.hasMatch(text);
  }

  static bool isChinaMobile(String mobile) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  static bool isNotNullEmptyStr(String? str) => null != str && "" != str.trim();

  static bool isNullValue<T>(T? value) => null == value;

  static TextInputFormatter getPasswordFormatter() =>
      FilteringTextInputFormatter.allow(
        // RegExp(r'[a-zA-Z0-9]'),
        RegExp(r'[a-zA-Z0-9@#$%^&+=!.]'),
      );

  static Future<void> captureWidgetToGallery(GlobalKey key) async {
    final RenderRepaintBoundary boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    var path = await AppUtils.createTempFile(
      dir: 'pic',
      fileName: 'invite.png',
    );

    // write file
    final buffer = pngBytes.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes));

    // save to gallery
    var result = await ImageGallerySaver.saveFile(path);
    if (result['isSuccess']) {
      AppWidget.showToast(Globe.savedToGallery);
    }
  }
}
