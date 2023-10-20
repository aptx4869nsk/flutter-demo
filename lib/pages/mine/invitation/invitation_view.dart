import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:kaibo/widgets/widget_to_image.dart';

import 'invitation_logic.dart';

class InvitationPage extends StatelessWidget {
  final logic = Get.find<InvitationLogic>();
  late GlobalKey _globalKey;

  InvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetToImage(
        builder: (key) {
          _globalKey = key;
          return SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageStr.icInvitationBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  _invitationHeader(context),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 1.sw - 120.w,
                          decoration: BoxDecoration(
                            color: Styles.cA8A8A8Opacity30,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Column(
                              children: [
                                Text(
                                  Globe.invitationCode,
                                  style: Styles.tsDefaultTxtClr20spBold,
                                ),
                                15.verticalSpace,
                                Text(
                                  logic.invitationCode.value,
                                  style: Styles
                                      .tsDefaultTxtClr18spSemiBoldLetterSpacing3sp,
                                ),
                                15.verticalSpace,
                                Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 150.w,
                                    height: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Styles.c_FFFFFF,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                    ),
                                    child: QrImageView(
                                      data: logic.buildQRContent(),
                                      size: 130.w,
                                      version: QrVersions.auto,
                                      eyeStyle: QrEyeStyle(
                                        eyeShape: QrEyeShape.square,
                                        color: Styles.defaultTxtClr,
                                      ),
                                      dataModuleStyle: QrDataModuleStyle(
                                        dataModuleShape:
                                            QrDataModuleShape.square,
                                        color: Styles.defaultTxtClr,
                                      ),
                                      backgroundColor: Styles.c_FFFFFF,
                                      errorStateBuilder: (cxt, err) {
                                        return Text(
                                          "Uh oh! Something went wrong...",
                                          style: Styles.tsSecondaryTxtClr12sp,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                15.verticalSpace,
                                GestureDetector(
                                  onTap: () => logic.saveToGallery(_globalKey),
                                  child: Text(
                                    Globe.longPressToSaveQrCode,
                                    style: Styles.tsB8B8B814sp,
                                  ),
                                ),
                                15.verticalSpace,
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => logic.copy(),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Styles.c_47B972,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      Globe.copyAppDownloadLink,
                                      style: Styles.tsFFFFFF14spBold,
                                    ),
                                  ),
                                )
                              ],
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
        },
      ),
    );
  }
}

Widget _invitationHeader(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Get.back(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageStr.icBackBlack.toImage
                      ..width = 24.w
                      ..height = 24.h
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
