import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'user_settings_logic.dart';

class UserSettingsPage extends StatelessWidget {
  final logic = Get.find<UserSettingsLogic>();

  UserSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.userSettings,
        backgroundColor: Styles.defaultAppBarBgClr,
        showUnderline: true,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Styles.c_FFFFFF,
                borderRadius: BorderRadius.circular(10.sp),
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
                children: [
                  // _buildItemView(
                  //   leading: ImageStr.icPhone,
                  //   label: Globe.modifyPhone,
                  //   onTap: logic.modifyPhone,
                  // ),
                  // Divider(
                  //   height: 5.h,
                  //   indent: 25,
                  //   endIndent: 25,
                  //   thickness: 0.6,
                  //   color: Styles.c_333333,
                  // ),
                  _buildItemView(
                    leading: ImageStr.icPwdLock,
                    label: Globe.modifyLoginPwd,
                    onTap: logic.modifyLoginPwd,
                  ),
                  Divider(
                    height: 5.h,
                    indent: 25,
                    endIndent: 25,
                    thickness: 0.6,
                    color: Styles.c_333333,
                  ),
                  _buildItemView(
                    leading: ImageStr.icBillingAddr,
                    label: Globe.modifyShippingAddr,
                    onTap: logic.modifyBillingAddr,
                  ),
                  Divider(
                    height: 5.h,
                    indent: 25,
                    endIndent: 25,
                    thickness: 0.6,
                    color: Styles.c_333333,
                  ),
                  Obx(
                    () => _buildItemView(
                      leading: ImageStr.icPwdLock,
                      label: logic.isWithdrawalPwdSet.value
                          ? Globe.modifyWithdrawalPwd
                          : Globe.setWithdrawalPwd,
                      onTap: logic.modifyWithdrawalPwd,
                    ),
                  ),
                  5.verticalSpace,
                ],
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: logic.safetyLogout,
              child: SizedBox(
                height: 48.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: Styles.defaultBtnBgClr,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageStr.icLogout.toImage
                        ..width = 25.w
                        ..height = 25.h,
                      5.horizontalSpace,
                      Text(
                        Globe.safetyLogout,
                        style: Styles.tsDefaultTxtClr14spBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildItemView({
  required String leading,
  required String label,
  Function? onTap,
}) =>
    InkWell(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    leading.toImage
                      ..width = 25.w
                      ..height = 25.h,
                    15.horizontalSpace,
                    label.toText..style = Styles.tsDefaultTxtClr14sp
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(1.0, 0.0),
                child: ImageStr.icGreyNext.toImage
                  ..width = 25.w
                  ..height = 25.h,
              ),
            ],
          ),
        ),
      ),
    );
