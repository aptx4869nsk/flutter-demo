import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/utils/logger.dart';

class UsdtLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final usdtAddressCtrl = TextEditingController();
  final bscAddressCtrl = TextEditingController();
  final trcAddr = ''.obs;
  final bscAddr = ''.obs;
  final editTrcAddr = true.obs;
  final editBscAddr = true.obs;
  final bindUsdtBtn = true.obs;

  @override
  void onInit() {
    if (indexLogic.profile.value.trcStatus == 1) {
      trcAddr.value = indexLogic.profile.value.trcAddress!;
      usdtAddressCtrl.text = trcAddr.value;
      editTrcAddr.value = false;
    }
    if (indexLogic.profile.value.bscStatus == 1) {
      bscAddr.value = indexLogic.profile.value.bscAddress!;
      bscAddressCtrl.text = bscAddr.value;
      editBscAddr.value = false;
    }
    if (indexLogic.profile.value.trcStatus == 1 &&
        indexLogic.profile.value.bscStatus == 1) {
      bindUsdtBtn.value = false;
    }
    // temp for test
    // usdtAddressCtrl.text = "TQQg4EL8o1BSeKJY4MJ8TB8XK7xufxFBv2";
    // bscAddressCtrl.text = "0x5aAeb6053F3E91C9b9A09f33669435E7Ef1BeAed";

    super.onInit();
  }

  void updateTrcAddr() => editTrcAddr.value = true;

  void updateBscAddr() => editBscAddr.value = true;

  void bind() {
    if (indexLogic.profile.value.trcStatus == 0 &&
        indexLogic.profile.value.bscStatus == 0) {
      // 未绑定
      if (usdtAddressCtrl.text.isEmpty && bscAddressCtrl.text.isEmpty) {
        AppWidget.showToast(Globe.plsEnterBindAddr);
        return;
      }
    }
    if (indexLogic.profile.value.trcStatus == 1) {
      // 已绑定TRC20地址
      if (bscAddressCtrl.text.isEmpty) {
        AppWidget.showToast(Globe.plsEnterBscAddr);
        return;
      }
    }
    if (indexLogic.profile.value.bscStatus == 1) {
      // 已绑定BSC地址
      if (usdtAddressCtrl.text.isEmpty) {
        AppWidget.showToast(Globe.plsEnterUsdtAddr);
        return;
      }
    }

    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        bool suc = false;
        if (indexLogic.profile.value.trcStatus == 0 &&
            indexLogic.profile.value.bscStatus == 0) {
          suc = await Apis.bindUsdt(
            usdtAddress: usdtAddressCtrl.text,
            bscAddress: bscAddressCtrl.text,
          );
        } else if (indexLogic.profile.value.bscStatus == 1) {
          // 绑定 USDT
          suc = await Apis.bindUsdt(usdtAddress: usdtAddressCtrl.text);
        } else {
          // 绑定 BSC
          suc = await Apis.bindUsdt(bscAddress: bscAddressCtrl.text);
        }
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('usdt e: $e $s');
      }
    });
  }

  @override
  void onClose() {
    usdtAddressCtrl.dispose();
    bscAddressCtrl.dispose();
    super.onClose();
  }
}
