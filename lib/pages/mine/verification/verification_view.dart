import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/widgets/input_box.dart';
import 'package:kaibo/widgets/touch_close_keyboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/views/input_box_view.dart';
import 'package:kaibo/widgets/network_image.dart';
import 'package:rxdart/rxdart.dart';
import 'verification_logic.dart';

class VerificationPage extends StatelessWidget {
  final logic = Get.find<VerificationLogic>();

  VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(
          title: Globe.myVerification,
          backgroundColor: Styles.defaultAppBarBgClr,
        ),
        backgroundColor: Styles.defaultScaffoldBgClr,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  logic.editRealName.value
                      ? InputBox.textBox(
                          label: Globe.realName,
                          hintText: Globe.plsEnterRealName,
                          controller: logic.realNameCtrl,
                          leadingIcon: ImageStr.icPerson,
                        )
                      : InputBoxView(
                          label: Globe.realName,
                          text: logic.realName.value,
                          leadingIcon: ImageStr.icPerson,
                          trailingTxt: logic.verificationStatus ==
                                      VerificationStatus.init ||
                                  logic.verificationStatus ==
                                      VerificationStatus.failed
                              ? Globe.edit
                              : null,
                          onClick: logic.verificationStatus ==
                                      VerificationStatus.init ||
                                  logic.verificationStatus ==
                                      VerificationStatus.failed
                              ? logic.updateRealName
                              : null,
                        ),
                  10.verticalSpace,
                  logic.editNrcNbr.value
                      ? InputBox.textBox(
                          label: Globe.nrcNbr,
                          hintText: Globe.plsEnterNrcNbr,
                          controller: logic.nrcNbrCtrl,
                          leadingIcon: ImageStr.icPerson,
                        )
                      : InputBoxView(
                          label: Globe.nrcNbr,
                          text: logic.nrcNbr.value,
                          leadingIcon: ImageStr.icPerson,
                          trailingTxt: logic.verificationStatus ==
                                      VerificationStatus.init ||
                                  logic.verificationStatus ==
                                      VerificationStatus.failed
                              ? Globe.edit
                              : null,
                          onClick: logic.verificationStatus ==
                                      VerificationStatus.init ||
                                  logic.verificationStatus ==
                                      VerificationStatus.failed
                              ? logic.updateNrcNbr
                              : null,
                        ),
                  10.verticalSpace,
                  Visibility(
                    visible:
                        logic.verificationStatus == VerificationStatus.success
                            ? false
                            : true,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Styles.c_E2F2D1,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1), //
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Globe.uploadNRC,
                            style: Styles.tsDefaultTxtClr14sp,
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 150.h,
                                  child: InkWell(
                                    onTap: () => logic.verificationStatus ==
                                                VerificationStatus.init ||
                                            logic.verificationStatus ==
                                                VerificationStatus.failed
                                        ? logic.pickImage(NrcType.front)
                                        : null,
                                    child: _imageBox(
                                      imgType: logic.nrcFrontImgType,
                                      nrcType: NrcType.front,
                                      file: logic.frontImgFile.value,
                                      path: logic.frontTempFilePath.value,
                                    ),
                                  ),
                                ),
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 150.h,
                                  child: InkWell(
                                    onTap: () => logic.verificationStatus ==
                                                VerificationStatus.init ||
                                            logic.verificationStatus ==
                                                VerificationStatus.failed
                                        ? logic.pickImage(NrcType.back)
                                        : null,
                                    child: _imageBox(
                                      imgType: logic.nrcBackImgType,
                                      nrcType: NrcType.back,
                                      file: logic.backImgFile.value,
                                      path: logic.backTempFilePath.value,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  45.verticalSpace,
                  Visibility(
                    visible:
                        logic.verificationStatus == VerificationStatus.pending,
                    child: SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Styles.defaultBtnBgClr,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                          child: Text(
                            Globe.pending,
                            style: Styles.tsDefaultTxtClr14spBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: logic.verificationStatus ==
                            VerificationStatus.init ||
                        logic.verificationStatus == VerificationStatus.failed,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: logic.verify,
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

Widget _imageBox({
  required ImageType imgType,
  required NrcType nrcType,
  required String path,
  required File file,
}) {
  switch (imgType) {
    case ImageType.network:
      {
        return ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          child: NetworkImageWidget(
            path: path,
            refreshTrigger: BehaviorSubject<int>.seeded(0),
          ),
        );
      }
    case ImageType.file:
      {
        if (file.path.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              image:  DecorationImage(
                image: AssetImage(
                  nrcType == NrcType.front ? ImageStr.icNrcFront : ImageStr.icNrcBack,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          );
        }
      }
  }
}
