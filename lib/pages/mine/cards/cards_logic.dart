import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/models/supported_bank.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class CardsLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final bankBranchCtrl = TextEditingController();
  final bankAccNbrCtrl = TextEditingController();
  final holderNameCtrl = TextEditingController();
  final bankName = ''.obs;
  final bankCode = ''.obs;
  final bankBranch = ''.obs;
  final bankAccNbr = ''.obs;
  final holderName = ''.obs;
  final editeBankName = true.obs;
  final editBankBranch = true.obs;
  final editBankAccNbr = true.obs;
  final editHolderName = true.obs;
  final enableBindBankBtn = true.obs;
  final enableCardsShimmer = true.obs;
  final banks = <SupportedBank>[].obs; // 绑定银行卡

  @override
  void onInit() {
    if (indexLogic.profile.value.bank?.status == 1) {
      bankCode.value = indexLogic.profile.value.bank?.code ?? "";
      bankName.value = indexLogic.profile.value.bank?.name ?? "";
      bankBranch.value = indexLogic.profile.value.bank?.address ?? "";
      bankAccNbr.value = indexLogic.profile.value.bank?.cardNumber ?? "";
      holderName.value = indexLogic.profile.value.bank?.cardName ?? "";
      editeBankName.value = false;
      editBankBranch.value = false;
      editBankAccNbr.value = false;
      editHolderName.value = false;
      enableBindBankBtn.value = false;
    }
    super.onInit();
  }

  @override
  void onReady() {
    getSupportedBanks();
    super.onReady();
  }

  void updateBankName() => editeBankName.value = true;

  void updateBankBranch() => editBankBranch.value = true;

  void updateBankAccNbr() => editBankAccNbr.value = true;

  void updateHolderName() => editHolderName.value = true;

  void onChangeBank(SupportedBank item) {
    bankName.value = item.name ?? '';
    bankCode.value = item.code ?? '';
  }

  void bind() {
    if (bankName.isEmpty) {
      AppWidget.showToast(Globe.plsSelectBankName);
      return;
    }
    if (bankBranchCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterBankBranch);
      return;
    }
    if (bankAccNbrCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterBankAccNbr);
      return;
    }
    if (bankAccNbrCtrl.text.length <= 11) {
      AppWidget.showToast(Globe.plsEnterValidBankAccNbr);
      return;
    }
    if (holderNameCtrl.text.isEmpty) {
      AppWidget.showToast(Globe.plsEnterHolderName);
      return;
    }
    if(holderNameCtrl.text.length <= 1) {
      AppWidget.showToast(Globe.plsEnterValidHolderName);
      return;
    }
    if (!AppUtils.isChineseName(holderNameCtrl.text)) {
      AppWidget.showToast(Globe.plsEnterValidHolderName);
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final suc = await Apis.bindBankCard(
          bankName: bankName.value,
          bankCode: bankCode.value,
          bankBranch: bankBranchCtrl.text,
          bankAccNbr: bankAccNbrCtrl.text,
          holderName: holderNameCtrl.text,
        );
        if (suc) {
          indexLogic.getProfile();
          Get.back();
        }
      } catch (e, s) {
        Logger.print('cards e: $e $s');
      }
    });
  }

  // 获取银行卡
  void getSupportedBanks() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        SupportedBanks data = await Apis.getBanks();
        banks.value = data.supportedBanks ?? [];
        enableCardsShimmer.value = false;
      } catch (e, s) {
        Logger.print('cards e: $e $s');
      }
    });
  }

  @override
  void onClose() {
    bankBranchCtrl.dispose();
    bankAccNbrCtrl.dispose();
    holderNameCtrl.dispose();
    super.onClose();
  }
}
