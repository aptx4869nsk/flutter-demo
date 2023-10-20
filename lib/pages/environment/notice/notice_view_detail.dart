import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/models/notice.dart';
import 'package:kaibo/utils/app_utils.dart';

class NoticeDetail extends StatelessWidget {
  final Notice noticeInfo;

  const NoticeDetail({
    required this.noticeInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.notificationDetail,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noticeInfo.title ?? '',
                style: Styles.tsDefaultTxtClr16spBold,
              ),
              5.verticalSpace,
              Html(
                data: noticeInfo.description ?? '',
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    color: Styles.defaultTxtClr,
                  ),
                },
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
        )
      ),
    );
  }
}
