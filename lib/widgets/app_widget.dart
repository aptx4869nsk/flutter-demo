import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_store/utils/enums.dart';
import 'package:mini_store/resources/styles.dart';

class AppWidget {
  static void showToast(String? msg) {
    if (msg == null) return;
    if (msg.trim().isNotEmpty) EasyLoading.showToast(msg);
  }

  static void showSnackBar(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Styles.c_333333,
      colorText: Styles.theme,
    );
  }

  static String getDioErrMsg(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return '连接服务器超时';
      case DioExceptionType.sendTimeout:
        return '服务器请求超时';
      case DioExceptionType.receiveTimeout:
        return '服务器响应超时';
      case DioExceptionType.badResponse:
        return '网络异常，请求断开'; // return '未知响应';
      case DioExceptionType.cancel:
        return '取消服务器请求';
      // case DioExceptionType.other:
      //   return '网络异常'; // return '未知异常出错';
      default:
        return '请求失败';
    }
  }

  static ApiErrType getRespErrType(Object e) {
    var resp = getRespErrMap(e);
    return resp['type'];
  }

  static String getRespErrMessage(Object e) {
    var resp = getRespErrMap(e);
    return resp['message'];
  }

  static Map<String, dynamic> getRespErrMap(Object e) {
    var respMap = Map<String, dynamic>.from(e as Map<String, dynamic>);
    return respMap;
  }

  static void showRespErrDialog(
      {String? msg, String? btnTxt, Function? apiReqFunc}) {
    EasyLoading.show(
      indicator: Column(
        children: [
          Icon(
            Icons.error,
            size: 38.sp,
            color: Styles.c_DA1F13,
          ),
          8.verticalSpace,
          Text(
            msg ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Styles.defaultTxtClr,
            ),
          ),
          25.verticalSpace,
          GestureDetector(
            onTap: () {
              EasyLoading.dismiss();
              apiReqFunc?.call();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: Styles.c_DA1F13,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  btnTxt ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.w,
                    color: Styles.defaultTxtClr,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
