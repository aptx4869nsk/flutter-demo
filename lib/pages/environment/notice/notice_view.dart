import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/models/notice.dart';
import 'notice_view_detail.dart';

import 'notice_logic.dart';

class NoticePage extends StatelessWidget {
  final logic = Get.find<NoticeLogic>();

  NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.notification,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: SmartRefresher(
            controller: logic.controller,
            onLoading: logic.onLoading,
            enablePullDown: false,
            enablePullUp: true,
            header: AppWidget.buildHeader(),
            footer: AppWidget.buildFooter(),
            child: ListView.builder(
              itemCount: logic.notices.length,
              itemBuilder: (_, index) => _buildNotification(
                context,
                logic.notices[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildNotification(context, Notice noticeInfo) => Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return NoticeDetail(
                  noticeInfo: noticeInfo,
                );
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: Styles.c_E2F2D1,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noticeInfo.title ?? '',
                style: Styles.tsDefaultTxtClr16spBold,
              ),
              10.verticalSpace,
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  AppUtils.formatDateTime(noticeInfo.createdAt!),
                  style: Styles.tsSecondaryTxtClr12sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
