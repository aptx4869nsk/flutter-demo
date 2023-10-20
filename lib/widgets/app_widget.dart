import 'dart:async';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/utils/enums.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppWidget {
  static void showToast(String? msg) {
    if (msg == null) return;
    if (msg.trim().isNotEmpty) EasyLoading.showToast(msg);
  }

  static Widget buildHeader() => WaterDropMaterialHeader(
        backgroundColor: Styles.defaultBtnBgClr,
      );

  static Widget buildFooter() => CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(
              Globe.loadStatusIdle,
              style: Styles.tsDefaultTxtClr14sp,
            );
          } else if (mode == LoadStatus.loading) {
            body = Text(
              Globe.loadStatusLoading,
              style: Styles.tsDefaultTxtClr14sp,
            );
          } else if (mode == LoadStatus.failed) {
            body = Text(
              Globe.loadStatusFailed,
              style: Styles.tsDefaultTxtClr14sp,
            );
          } else if (mode == LoadStatus.canLoading) {
            body = Text(
              Globe.loadStatusCanLoading,
              style: Styles.tsDefaultTxtClr14sp,
            );
          } else if (mode == LoadStatus.noMore) {
            body = Text(
              Globe.loadStatusNoMore,
              style: Styles.tsDefaultTxtClr14sp,
            );
          } else {
            body = const SizedBox();
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      );

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
        return '服务器链接断开'; // return '未知响应';
      case DioExceptionType.cancel:
        return '取消服务器请求';
      case DioExceptionType.connectionError:
        return '请求断开';
      case DioExceptionType.unknown:
        return '未知断开'; // 请求断开
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

  static void showRespErrDialog({
    String? msg,
    String? btnTxt,
    Function? apiReqFunc,
  }) {
    EasyLoading.show(
      indicator: Column(
        children: [
          Icon(
            Icons.error,
            size: 38.sp,
            color: Styles.failedClr,
          ),
          8.verticalSpace,
          Text(
            msg ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Styles.c_FFFFFF,
            ),
          ),
          25.verticalSpace,
          GestureDetector(
            behavior: HitTestBehavior.translucent,
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
                color: Styles.defaultBtnBgClr,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.r),
                ),
              ),
              child: Center(
                child: Text(
                  btnTxt ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.w,
                    color: Styles.c_FFFFFF,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Future<String?> showCountryCodePicker() async {
    Completer<String> completer = Completer();
    return completer.future;
  }
}
