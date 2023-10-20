import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/models/preload.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/shimmer/environment_shimmer.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:kaibo/widgets/video_swapper.dart';
import 'package:marquee/marquee.dart';
import 'package:kaibo/shimmer/environment_news_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'environment_logic.dart';
import 'package:kaibo/models/history.dart';
import 'company_info_detail.dart';

class EnvironmentPage extends StatelessWidget {
  final logic = Get.find<EnvironmentLogic>();

  EnvironmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Container(
          width: 1.sw,
          height: 1.sh - 66.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageStr.icHomeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: SmartRefresher(
            controller: logic.controller,
            onRefresh: logic.refreshData,
            header: AppWidget.buildHeader(),
            footer: AppWidget.buildFooter(),
            enablePullDown: true,
            enablePullUp: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  logic.indexLogic.enableEnvironmentShimmer.value
                      ? const EnvironmentShimmer()
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).padding.top,
                            ),
                            _videosSwapper(
                              videos: logic.indexLogic.preload.value.video ?? [],
                              oss: logic.indexLogic.preload.value.filePath ?? '',
                              isShowCheckIn:
                                  !logic.indexLogic.enableMineShimmer.value,
                              onCheckIn: logic.checkIn,
                            ),
                            6.verticalSpace,
                            _marquee(
                              ad: logic.indexLogic.preload.value.ad?.title ?? ' ',
                              onTapAd: logic.notification,
                            ),
                            15.verticalSpace,
                            _companyInfo(
                              context,
                              logic.indexLogic.preload.value.companyInfo,
                            ),
                          ],
                        ),
                  logic.indexLogic.enableEnvironmentNewsShimmer.value
                      ? const EnvironmentNewsShimmer()
                      : Column(
                          children: [
                            _newsHeader(
                              moreNews: logic.moreNews,
                            ),
                            Column(
                              children: List.generate(
                                logic.indexLogic.news.length,
                                (index) => _buildNewsRecord(
                                  appName:
                                      logic.appLogic.packageInfo?.appName ?? '',
                                  newsInfo: logic.indexLogic.news[index],
                                  oss: logic.indexLogic.preload.value.filePath ??
                                      "",
                                  onTap: logic.newsDetail,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _videosSwapper({
  required List<String> videos,
  required String oss,
  required bool isShowCheckIn,
  Function? onCheckIn,
}) =>
    SizedBox(
      width: double.infinity,
      height: 230.h, // 200 + (40 - 20) + 10
      child: ClipRRect(
        child: Stack(
          children: [
            // Video Swapper
            Positioned(
              child: SizedBox(
                height: 200.h,
                child: VideoSwapper(
                  videos: videos,
                  oss: oss,
                ),
              ),
            ),
            // Check in
            Positioned(
              top: 180.h,
              right: 20.w, // 40 + 20
              child: Visibility(
                visible: isShowCheckIn,
                child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => onCheckIn?.call(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Styles.defaultBtnBgClr,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Styles.cDefaultTxtClrOpacity20,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          Globe.checkIn,
                          style: Styles.tsDefaultTxtClr12spBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget _marquee({
  required String ad,
  required Function onTapAd,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
            color: Styles.c_FFFFFF,
            border: Border.all(color: Styles.cThemeOpacity60, width: 1.w),
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Styles.cThemeOpacity40,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: Center(
                  child: Image.asset(
                    ImageStr.icNotice,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => onTapAd.call(),
                  child: Marquee(
                    text: ad,
                    style: Styles.tsDefaultTxtClr14spSemiBoldOverflowEllipsis,
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget _companyInfo(context, CompanyInfo? info) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return CompanyInfoDetail(
                companyInfo: info!,
              );
            },
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: Styles.c_FFFFFF,
              border: Border.all(color: Styles.cThemeOpacity60, width: 1.w),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Styles.cThemeOpacity40,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              info?.title ?? '',
              style: Styles.tsDefaultTxtClr14spBold,
            ),
          ),
        ),
      ),
    );

Widget _newsHeader({required Function moreNews}) => SizedBox(
      height: 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageStr.icHot.toImage
                  ..width = 25.w
                  ..height = 20.h,
                Text(
                  Globe.news,
                  style: Styles.tsDefaultTxtClr14sp,
                ),
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => moreNews.call(),
              child: Row(
                children: [
                  Text(
                    Globe.newsMore,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                  ImageStr.icGreyNext.toImage
                    ..width = 15.w
                    ..height = 15.h,
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget _buildNewsRecord({
  required NewsHistory newsInfo,
  required String appName,
  required String oss,
  required Function onTap,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
