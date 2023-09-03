import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

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

  ///  compress file and get file.
  static Future<XFile?> compressImageAndGetFile(File file) async {
    var path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1);
    var targetPath = await createTempFile(name: name, dir: 'pic');
    CompressFormat format = CompressFormat.jpeg;
    if (name.endsWith(".jpg") || name.endsWith(".jpeg")) {
      format = CompressFormat.jpeg;
    } else if (name.endsWith(".png")) {
      format = CompressFormat.png;
    } else if (name.endsWith(".heic")) {
      format = CompressFormat.heic;
    } else if (name.endsWith(".webp")) {
      format = CompressFormat.webp;
    }

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 480,
      minHeight: 800,
      format: format,
    );
    return result;
  }

  static Future<String> createTempFile({
    required String dir,
    required String name,
  }) async {
    final storage = (Platform.isIOS
        ? await getTemporaryDirectory()
        : await getExternalStorageDirectory());
    Directory directory = Directory('${storage!.path}/$dir');
    if (!(await directory.exists())) {
      directory.create(recursive: true);
    }
    File file = File('${directory.path}/$name');
    if (!(await file.exists())) {
      file.create();
    }
    return file.path;
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

  static String getTimeFormat1() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'yyyy年MM月dd日' : 'yyyy/MM/dd';
  }

  static String getTimeFormat2() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'yyyy年MM月dd日 HH时mm分' : 'yyyy/MM/dd HH:mm';
  }

  static String getTimeFormat3() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'MM月dd日 HH时mm分' : 'MM/dd HH:mm';
  }

  static TextInputFormatter getPasswordFormatter() => FilteringTextInputFormatter.allow(
    // RegExp(r'[a-zA-Z0-9]'),
    RegExp(r'[a-zA-Z0-9@#$%^&+=!.]'),
  );
}
