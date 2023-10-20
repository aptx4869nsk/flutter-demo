import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:kaibo/config.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/models/api_resp.dart';
import 'package:kaibo/models/system_maintenance.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/views/maintenance_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/utils/logger.dart';

var dio = Dio();

class HttpUtil {
  HttpUtil._();

  static void init() {
    dio
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ))
      // ..interceptors.add(HttpFormatter())
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        return handler.next(options); //continue
        // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      }, onError: (DioException e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      }));

    // 配置dio实例
    dio.options.baseUrl = Config.appApiUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  static Future<bool> customRetryEvaluator(
    DioException error,
    int attempt,
  ) async {
    bool shouldRetry = false;
    if (error.type == DioExceptionType.connectionError && attempt <= 3) {
      // 只在连接超时且重试次数小于等于3时重试
      shouldRetry = true;
    }
    return shouldRetry;
  }

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('https://www.baidu.com/');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future get(
    String path, {
    bool showErrorToast = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var result = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      var resp = ApiResp.fromJson(result.data!);

      if (resp.code == 1000) {
        return resp.data;
      } else if (resp.code == 1001) {
        // Unauthorized
        await DataSp.removeLoginCertificate();
        AppNavigator.startLogin();
      } else if (resp.code == 1007) {
        // System Maintenance
        SystemMaintenance? systemMaintenance =
            SystemMaintenance.fromJson(resp.data!);
        Get.dialog(
          MaintenanceView(
            htmlData: systemMaintenance.description,
          ),
        );
        return Future.error(resp.message as Object);
      }
      if (showErrorToast) {
        if (resp.errors.length == 0) {
          AppWidget.showRespErrDialog(
            msg: resp.message,
            btnTxt: Globe.close,
          );
          return Future.error(resp.message as Object);
        } else {
          List<String> lst = resp.errors.keys.toList();
          String msg = "";
          for (var val in lst) {
            msg += resp.errors[val];
          }
          AppWidget.showRespErrDialog(
            msg: msg,
            btnTxt: Globe.close,
          );
          return Future.error(resp.errors);
        }
      }
    } catch (error) {
      // if (error is DioException) {
      //   AppWidget.showRespErrDialog(
      //     msg: AppWidget.getDioErrMsg(error.type),
      //     btnTxt: Globe.close,
      //   );
      //   return Future.error(error);
      // }
      return Future.error(error);
      // Nodejs error
      // final errorMsg = '接口：$path  信息：${error.toString()}';
      // if (showErrorToast) AppWidget.showToast(errorMsg);
      // return Future.error(error);
    }
  }

  ///
  static Future post(
    String path, {
    dynamic data,
    bool showErrorToast = true,
    bool showSuccessToast = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      data ??= {};
      options ??= Options();
      options.headers ??= {};

      var result = await dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      var resp = ApiResp.fromJson(result.data!);
      if (resp.code == 1000) {
        if (showSuccessToast) AppWidget.showToast(resp.message);
        return resp.data;
      } else if (resp.code == 1001) {
        // Unauthorized
        await DataSp.removeLoginCertificate();
        AppNavigator.startLogin();
      } else if (resp.code == 1007) {
        // System Maintenance
        SystemMaintenance? systemMaintenance =
            SystemMaintenance.fromJson(resp.data!);
        Get.dialog(
          MaintenanceView(
            htmlData: systemMaintenance.description,
          ),
        );
        return Future.error(resp.message as Object);
      }
      if (showErrorToast) {
        if (resp.errors.length == 0) {
          AppWidget.showRespErrDialog(
            msg: resp.message,
            btnTxt: Globe.close,
          );
          return Future.error(resp.message as Object);
        } else {
          List<String> lst = resp.errors.keys.toList();
          String msg = "";
          for (var val in lst) {
            msg += resp.errors[val];
          }
          AppWidget.showRespErrDialog(
            msg: msg,
            btnTxt: Globe.close,
          );
          return Future.error(resp.errors);
        }
      }
    } catch (error) {
      // 不现实错误提示 - 客户要求
      // if (error is DioException) {
      //   AppWidget.showRespErrDialog(
      //     msg: AppWidget.getDioErrMsg(error.type),
      //     btnTxt: Globe.close,
      //   );
      //   return Future.error(error);
      // }
      // Nodejs error
      // final errorMsg = '接口：$path  信息：${error.toString()}';
      // if (showErrorToast) AppWidget.showToast(errorMsg);
      return Future.error(error);
    }
  }

  /// fileType: file = "1",video = "2",picture = "3"
  static Future<bool> uploadImage(
    String url, {
    required String path,
    bool showErrorToast = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    String fileName =
        path.substring(path.lastIndexOf("/") + 1).split('image_picker').last;
    final mf = await MultipartFile.fromFile(path, filename: fileName);

    var formData = FormData.fromMap({
      'image': mf,
    });

    try {
      var result = await dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer ${DataSp.userToken}'},
        ),
      );
      var resp = ApiResp.fromJson(result.data!);
      if (resp.code == 1000) {
        return true;
      } else {
        if (showErrorToast) {
          if (resp.code == 1001) {
// Unauthorized
            await DataSp.removeLoginCertificate();
            AppNavigator.startLogin(); // startLogin error
          }
        }
        return false;
      }
    } catch (error) {
      // 不现实错误提示 - 客户要求
      // if (error is DioException) {
      //   final errorMsg = '接口：$path  信息：${error.message}';
      //   if (showErrorToast) AppWidget.showToast(errorMsg);
      //   return false;
      // }
      // final errorMsg = '接口：$path  信息：${error.toString()}';
      // if (showErrorToast) AppWidget.showToast(errorMsg);
      return false;
    }
  }

  static Future download(
    String url, {
    required String cachePath,
    CancelToken? cancelToken,
    Function(int count, int total)? onProgress,
  }) {
    return dio.download(
      url,
      cachePath,
      options: Options(
        receiveTimeout: const Duration(minutes: 3),
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onProgress,
    );
  }

  static Future download2(
    String url, {
    required String cachePath,
    CancelToken? cancelToken,
    Function(int count, int total)? onProgress,
  }) {
    return dio.download(
      url,
      cachePath,
      options: Options(
        receiveTimeout: const Duration(minutes: 3),
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onProgress,
    );
  }
}
