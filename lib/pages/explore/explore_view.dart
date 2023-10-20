import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/pages/explore/explore_logic.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/models/product.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/shimmer/explore_shimmer.dart';

class ExplorePage extends StatelessWidget {
  final logic = Get.find<ExploreLogic>();

  ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => logic.indexLogic.preload.value.canBuy == 0 &&
              logic.indexLogic.enableExploreShimmer.value
          ? const ExploreShimmer()
          : Scaffold(
              appBar: TitleBar.explore(),
              backgroundColor: Styles.defaultScaffoldBgClr,
              body: SmartRefresher(
                controller: logic.controller,
                onRefresh: logic.refreshData,
                onLoading: logic.onLoading,
                enablePullDown: true,
                enablePullUp: true,
                header: AppWidget.buildHeader(),
                footer: AppWidget.buildFooter(),
                child: ListView.builder(
                  itemCount: logic.indexLogic.products.length,
                  itemBuilder: (_, index) => _buildItemView(
                    logic.indexLogic.products[index],
                    buy: logic.buy,
                    oss: logic.indexLogic.preload.value.filePath ?? '',
                  ),
                ),
              ),
            ),
    );
  }
}

Widget _buildItemView(
  Product productInfo, {
  Function? buy,
  required String oss,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Container(
        decoration: BoxDecoration(
          color: Styles.c_FFFFFF,
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Styles.cDefaultTxtClrOpacity20,
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image
            SizedBox(
              height: 140.h,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: productInfo.image == null
                      ? Image.asset(ImageStr.icNoImage, fit: BoxFit.cover)
                      : NetworkImageWidget(
                          path: "$oss${productInfo.image}",
                          refreshTrigger: BehaviorSubject<int>.seeded(0),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Globe.productName,
                        style: Styles.tsDefaultTxtClr14sp,
                      ),
                      Text(
                        productInfo.name ?? '',
                        style: Styles.tsDefaultTxtClr14sp,
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Globe.earnRate,
                        style: Styles.tsDefaultTxtClr14sp,
                      ),
                      Text(
                        "${productInfo.earnRate! * 100}%",
                        style: Styles.tsDefaultTxtClr14sp,
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    color: Colors.grey.withOpacity(.3),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Globe.minBuy,
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                              6.verticalSpace,
                              Text(
                                "${productInfo.minPrice}",
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                Globe.maxBuy,
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                              6.verticalSpace,
                              Text(
                                "${productInfo.maxPrice}",
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Globe.duration,
                                style: Styles.tsDefaultTxtClr14sp,
                              ),
                              6.verticalSpace,
                              Text(
                                sprintf(
                                  Globe.durationDays,
                                  ['${productInfo.duration}'],
                                ),
                                style: Styles.tsDefaultTxtClr14sp,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  InkWell(
                    onTap: () => buy?.call(productInfo),
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Styles.defaultBtnBgClr,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Globe.buyNow,
                          style: Styles.tsDefaultTxtClr14spBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
