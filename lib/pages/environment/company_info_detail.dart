import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kaibo/models/preload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/utils/custom_ext.dart';

class CompanyInfoDetail extends StatelessWidget {
  final CompanyInfo companyInfo;

  const CompanyInfoDetail({required this.companyInfo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.detail,
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
                companyInfo.title ?? '',
                style: Styles.tsDefaultTxtClr14spBold,
              ),
              6.verticalSpace,
              Html(
                data: companyInfo.body ?? '',
                style: {
                  "body": Style(
                    fontSize: FontSize(14.sp),
                    color: Styles.defaultTxtClr,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
