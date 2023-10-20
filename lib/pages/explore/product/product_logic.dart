import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/models/product.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';

class ProductLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final oss = Get.find<IndexLogic>().preload.value.filePath;
  final amountCtrl = TextEditingController();
  late Product product;

  @override
  void onInit() {
    product = Get.arguments['product'] ?? '';
    super.onInit();
  }

  void buyProduct() async {
    if (AppUtils.isNullValue(product.id)) return;
    if(amountCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterDepositAmt);
      return;
    }
    // amount limitation
    int buyAmt = int.parse(amountCtrl.text);
    if (buyAmt < product.minPrice!) {
      AppWidget.showToast("${Globe.minBuy} ${product.minPrice}");
      return;
    }
    if (buyAmt > product.maxPrice!) {
      AppWidget.showToast("${Globe.maxBuy} ${product.maxPrice}");
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        var suc = await Apis.buyProduct(
          productId: product.id!,
          amount: amountCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('product e: $e $s');
      }
    });
  }
}
