import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/models/supported_bank.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/shimmer/cards_shimmer.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/widgets/custom_dropdown.dart';
import 'package:kaibo/views/input_box_view.dart';
import 'cards_logic.dart';

class CardsPage extends StatelessWidget {
  final logic = Get.find<CardsLogic>();

  CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.myCards,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => logic.enableCardsShimmer.value
              ? const CardsShimmer()
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      children: [
                        logic.editeBankName.value
                            ? InputBoxView(
                                label: Globe.bankName,
                                text: logic.bankName.value,
                                leadingIcon: ImageStr.icBankName,
                                customTrailing:
                                    CustomDropdownMenu<SupportedBank>(
                                  onSelected: (item) =>
                                      logic.onChangeBank(item),
                                  itemBuilder: (BuildContext context) {
                                    return List<
                                            PopupMenuEntry<
                                                SupportedBank>>.generate(
                                        logic.banks.length * 2 - 1,
                                        (int index) {
                                      if (index.isEven) {
                                        final item = logic.banks[index ~/ 2];
                                        return CustomDropdownMenuItem<
                                            SupportedBank>(
                                          value: item,
                                          text: item.name ?? '',
                                        );
                                      } else {
                                        return const DropdownDivider();
                                      }
                                    });
                                  },
                                  child: Center(
                                    child: ImageStr.icArrowDown.toImage
                                      ..width = 25.w
                                      ..height = 25.h,
                                  ),
                                ),
                              )
                            : InputBoxView(
                                label: Globe.bankName,
                                text: logic.bankName.value,
                                leadingIcon: ImageStr.icBankName,
                                // trailingTxt: Globe.edit,
                                // onClick: logic.updateBankName,
                              ),
                        10.verticalSpace,
                        logic.editBankBranch.value
                            ? InputBox.textBox(
                                label: Globe.bankBranch,
                                hintText: Globe.plsEnterBankBranch,
                                controller: logic.bankBranchCtrl,
                                leadingIcon: ImageStr.icBankBranch,
                              )
                            : InputBoxView(
                                label: Globe.bankBranch,
                                text: logic.bankBranch.value,
                                leadingIcon: ImageStr.icBankBranch,
                                // trailingTxt: Globe.edit,
                                // onClick: logic.updateBankBranch,
                              ),
                        10.verticalSpace,
                        logic.editBankAccNbr.value
                            ? InputBox.numberBox(
                                label: Globe.bankAccNbr,
                                hintText: Globe.plsEnterBankAccNbr,
                                controller: logic.bankAccNbrCtrl,
                                leadingIcon: ImageStr.icBankAccountNbr,
                              )
                            : InputBoxView(
                                label: Globe.bankAccNbr,
                                text: logic.bankAccNbr.value,
                                leadingIcon: ImageStr.icBankAccountNbr,
                                // trailingTxt: Globe.edit,
                                // onClick: logic.updateBankAccNbr,
                              ),
                        10.verticalSpace,
                        logic.editHolderName.value
                            ? InputBox.textBox(
                                label: Globe.holderName,
                                hintText: Globe.plsEnterHolderName,
                                controller: logic.holderNameCtrl,
                                leadingIcon: ImageStr.icPerson,
                              )
                            : InputBoxView(
                                label: Globe.holderName,
                                text: logic.holderName.value,
                                leadingIcon: ImageStr.icPerson,
                                // trailingTxt: Globe.edit,
                                // onClick: logic.updateHolderName,
                              ),
                        45.verticalSpace,
                        Visibility(
                          visible: logic.enableBindBankBtn.value,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: logic.bind,
                            child: SizedBox(
                              height: 48.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Styles.defaultBtnBgClr,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                  child: Text(
                                    Globe.confirm,
                                    style: Styles.tsDefaultTxtClr14spBold,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
