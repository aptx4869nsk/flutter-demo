import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:kaibo/shimmer/news_detail_shimmer.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'news_detail_logic.dart';

class NewsDetailPage extends StatelessWidget {
  final logic = Get.find<NewsDetailLogic>();

  NewsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.newsDetail,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => logic.enableNewsDetailShimmer.value
            ? const NewsDetailShimmer()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1.sw,
                        height: 190.h,
                        child: NetworkImageWidget(
                          path:
                              "${logic.indexLogic.preload.value.filePath}${logic.newsInfo.value.image}",
                          refreshTrigger: BehaviorSubject<int>.seeded(0),
                        ),
                      ),
                      15.verticalSpace,
                      Text(
                        logic.newsInfo.value.title ?? '',
                        style: Styles.tsDefaultTxtClr20spSemiBold,
                      ),
                      5.verticalSpace,
                      Html(
                        data: logic.newsInfo.value.description ?? '',
                        style: {
                          "body": Style(
                            fontSize: FontSize(14.sp),
                            color: Styles.defaultTxtClr,
                            textAlign: TextAlign.justify,
                          ),
                        },
                      ),
                      15.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          AppUtils.formatDateTime(
                              logic.newsInfo.value.createdAt!),
                          style: Styles.tsSecondaryTxtClr14sp,
                        ),
                      ),
                      40.verticalSpace,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
