import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/models/history.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:rxdart/rxdart.dart';

import 'news_logic.dart';

class NewsPage extends StatelessWidget {
  final logic = Get.find<NewsLogic>();

  NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.news,
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
              itemCount: logic.histories.length,
              itemBuilder: (_, index) => _buildNewsRecord(
                appName: logic.appLogic.packageInfo?.appName ?? '',
                newsInfo: logic.histories[index],
                oss: logic.oss,
                onTap: logic.newsDetail,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildNewsRecord({
  required NewsHistory newsInfo,
  required String appName,
  required String oss,
  required Function onTap,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap.call(newsInfo.id),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      Text(
                        newsInfo.title ?? '',
                        style: Styles.tsDefaultTxtClr17spSemiBold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          text: "$appName\t\t",
                          style: Styles.tsSecondaryTxtClr12sp,
                          children: <TextSpan>[
                            TextSpan(
                              text: AppUtils.formatDate(newsInfo.createdAt!),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    // child: Image.network(
                    //   "$oss${newsInfo.image}",
                    //   fit: BoxFit.contain,
                    // ),
                    child: NetworkImageWidget(
                      path: "$oss${newsInfo.image}",
                      refreshTrigger: BehaviorSubject<int>.seeded(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
