import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class BillingAddressLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final phoneCtrl = TextEditingController();
  final shippingAddrCtrl = TextEditingController();
  final phone = ''.obs;
  final shippingAddr = ''.obs;
  final editPhone = true.obs;
  final editShippingAddr = true.obs;

  @override
  void onInit() {
    if (indexLogic.profile.value.shippingAddressStatus == 1) {
      phone.value = indexLogic.profile.value.shippingPhone ?? "";
      phoneCtrl.text = phone.value;
      editPhone.value = false;
      shippingAddr.value = indexLogic.profile.value.shippingAddress ?? "";
      shippingAddrCtrl.text = shippingAddr.value;
      editShippingAddr.value = false;
    }
    super.onInit();
  }

  void updateShippingPhone() => editPhone.value = true;

  void updateShippingAddr() => editShippingAddr.value = true;

  void modifyShippingAddr() {
    if (phoneCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterShippingPhone);
      return;
    }
    if(!AppUtils.isChinaMobile(phoneCtrl.text)) {
      AppWidget.showToast(Globe.plsEnterRightPhone);
      return;
    }
    if (shippingAddrCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterShippingAddr);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      if (shippingAddrCtrl.text.isEmpty) {
        AppWidget.showToast(Globe.plsEnterShippingAddr);
        return;
      }
      try {
        final suc = await Apis.bindShippingAddress(
          address: shippingAddrCtrl.text,
          phone: phoneCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('binding address e: $e $s');
      }
    });
  }

  @override
  void onClose() {
    phoneCtrl.dispose();
    shippingAddrCtrl.dispose();
    super.onClose();
  }
}
