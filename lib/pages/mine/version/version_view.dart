import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'version_logic.dart';

class VersionPage extends StatelessWidget {
  final logic = Get.find<VersionLogic>();

  VersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageStr.icVersionBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              _versionHeader(context),
              160.verticalSpace,
              // ImageStr.icApp.toImage
              //   ..width = 75.w
              //   ..height = 75.h,
              75.verticalSpace,
              20.verticalSpace,
              Text(
                logic.appLogic.packageInfo?.appName ?? '',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              5.verticalSpace,
              Text(
                logic.appLogic.packageInfo?.version ?? '',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              Visibility(
                visible: !logic.appLogic.canUpdate,
                child: Text(
                  Globe.appAlreadyLatestVersion,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _versionHeader(BuildContext context) => Padding(
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
