import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/widgets/input_box.dart';

import 'product_logic.dart';

class ProductPage extends StatelessWidget {
  final logic = Get.find<ProductLogic>();

  ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.productDetails,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh - MediaQuery.of(context).padding.top - 45.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                // Image
                SizedBox(
                  height: 140.h,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: logic.product.image == null
                          ? Image.asset(ImageStr.icNoImage, fit: BoxFit.cover)
                          : NetworkImageWidget(
                              path: "${logic.oss}${logic.product.image}",
                              refreshTrigger: BehaviorSubject<int>.seeded(0),
                            ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Globe.productName,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    Text(
                      logic.product.name ?? '',
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
                      "${logic.product.earnRate! * 100}%",
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Globe.minBuy,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    Text(
                      "${logic.product.minPrice}",
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Globe.maxBuy,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    Text(
                      "${logic.product.maxPrice}",
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Globe.duration,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    Text(
                      sprintf(
                        Globe.durationDays,
                        ['${logic.product.duration}'],
                      ),
                      style: Styles.tsDefaultTxtClr14sp,
                    )
                  ],
                ),
                6.verticalSpace,
                InputBox.numberBox(
                  label: Globe.depositAmt,
                  hintText: Globe.plsEnterDepositAmt,
                  controller: logic.amountCtrl,
                  leadingIcon: ImageStr.icDepositAmt,
                ),
                const Spacer(),
                InkWell(
                  onTap: logic.buyProduct,
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
                90.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
