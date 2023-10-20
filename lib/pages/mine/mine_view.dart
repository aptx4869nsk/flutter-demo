import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/app_utils.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/models/profile.dart';
import 'package:sprintf/sprintf.dart';
import 'package:kaibo/shimmer/mine_shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/widgets/app_widget.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.find<MineLogic>();

  MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  Scaffold(
              backgroundColor: Styles.defaultScaffoldBgClr,
              body: SmartRefresher(
                controller: logic.controller,
                onRefresh: logic.refreshData,
                header: AppWidget.buildHeader(),
                footer: AppWidget.buildFooter(),
                enablePullDown: true,
                enablePullUp: false,
                child: SingleChildScrollView(
                  child: logic.indexLogic.enableMineShimmer.value ? const MineShimmer() : Column(
                    children: [
                      _profileHeader(
                        context,
                        profile: logic.indexLogic.profile.value,
                        onTapUserDeposit: logic.userDeposit,
                        onTapUserWithdrawal: logic.userWithdrawal,
                        onTapUserSettings: logic.userSettings,
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          children: [
                            // 我的资产
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyAssets,
                                title: Globe.myAssets,
                                onTap: logic.userAssets,
                              ),
                            ),
                            // 我的订单
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyOrders,
                                title: Globe.myOrders,
                                onTap: logic.userOrders,
                              ),
                            ),
                            // 我的团队
                            Visibility(
                              visible: (logic.indexLogic.preload.value
                                          .canViewMember ??
                                      [])
                                  .contains(
                                      logic.indexLogic.profile.value.userType ??
                                          0),
                              child: _buildItemView(
                                item: Item(
                                  leading: ImageStr.icMyTeam,
                                  title: Globe.myTeam,
                                  onTap: logic.userTeam,
                                ),
                              ),
                            ),
                            // 邀请好友
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyInvitation,
                                title: Globe.myInvitation,
                                onTap: logic.userInvitation,
                              ),
                            ),
                            // 实名认证
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyVerification,
                                title: Globe.myVerification,
                                onTap: logic.userVerification,
                              ),
                            ),
                            // 绑定银行卡
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyCards,
                                title: Globe.myCards,
                                onTap: logic.userCards,
                              ),
                            ),
                            // 绑定USDT地址
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyUsdt,
                                title: Globe.myUsdt,
                                onTap: logic.userUsdt,
                              ),
                            ),
                            // 我的碳积分
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyPoints,
                                title: Globe.myPoints,
                                onTap: logic.userPoints,
                              ),
                            ),
                            // 系统版本
                            _buildItemView(
                              item: Item(
                                leading: ImageStr.icMyVersion,
                                title: Globe.myVersion,
                                onTap: logic.userVersion,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget _profileHeader(
  BuildContext context, {
  Profile? profile,
  Function()? onTapUserDeposit,
  Function()? onTapUserWithdrawal,
  Function()? onTapUserSettings,
}) =>
    SizedBox(
      width: 1.sw,
      height: 220.h,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageStr.icMineBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !AppUtils.isNullValue(profile?.type),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 4.sp,
                        ),
                        decoration: BoxDecoration(
                          color: Styles.c_C6E37E,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.sp),
                          ),
                        ),
                        child: Text(
                          profile?.type ?? '',
                          style: Styles.tsDefaultTxtClr12sp,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !AppUtils.isNullValue(profile?.name),
                      child: Text(
                        profile!.name!,
                        style: Styles.tsDefaultTxtClr16sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: !AppUtils.isNullValue(profile.balance),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Globe.points,
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        Text(
                          profile.balance ?? '--',
                          style: Styles.tsDefaultTxtClr14sp,
                        ),
                        18.verticalSpace,
                        Text(
                          sprintf(Globe.userAccount, [profile.phone]),
                          style: Styles.tsDefaultTxtClr10sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: ImageStr.icUserDeposit.toImage
                          ..width = 25.w
                          ..height = 25.h
                          ..label = Globe.userDeposit
                          ..onTap = onTapUserDeposit,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                      height: 22.h,
                      child: Container(
                        color: Styles.cDividerOpacity60,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ImageStr.icUserWithdrawal.toImage
                          ..width = 25.w
                          ..height = 25.h
                          ..label = Globe.userWithdrawal
                          ..onTap = onTapUserWithdrawal,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                      height: 22.h,
                      child: Container(
                        color: Styles.cDividerOpacity60,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ImageStr.icUserSettings.toImage
                          ..width = 20.w
                          ..height = 20.h
                          ..label = Globe.userSettings
                          ..onTap = onTapUserSettings,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

class Item {
  final String leading;
  final String title;
  final String? trailing;
  final String? verified;
  final Function()? onTap;

  Item({
    required this.leading,
    required this.title,
    this.verified,
    this.trailing,
    this.onTap,
  });
}

Widget _buildItemView({required Item item}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: InkWell(
      onTap: item.onTap,
      child: SizedBox(
        height: 48.h,
        child: Container(
          decoration: BoxDecoration(
            color: Styles.c_E2F2D1,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                color: Styles.cDefaultTxtClrOpacity20,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 55.w,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Styles.c_C6E37E,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: item.leading.toImage
                            ..width = 25.w
                            ..height = 25.h,
                        ),
                      ),
                    ),
                    15.horizontalSpace,
                    Text(
                      item.title,
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item.verified ?? '',
                      style: Styles.tsDefaultTxtClr14sp,
                    ),
                    5.horizontalSpace,
                    Align(
                      alignment: const Alignment(1.0, 0.0),
                      child: item.trailing?.toImage
                        ?..width = 15.w
                        ..height = 15.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
