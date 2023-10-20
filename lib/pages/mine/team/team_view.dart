import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/title_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/models/team.dart';
import 'package:kaibo/widgets/app_widget.dart';

import 'team_logic.dart';

class TeamPage extends StatelessWidget {
  final logic = Get.find<TeamLogic>();

  TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: Globe.myTeam,
        backgroundColor: Styles.defaultAppBarBgClr,
      ),
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Obx(
        () => Column(
          children: [
            _teamHeader(
              teamSpendAmt: "${logic.teamsEarn.value}",
              teamMembersCount: "${logic.totalCount.value}",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: SmartRefresher(
                  controller: logic.controller,
                  onLoading: logic.onLoading,
                  enablePullDown: false,
                  enablePullUp: true,
                  header: AppWidget.buildHeader(),
                  footer: AppWidget.buildFooter(),
                  child: ListView.builder(
                    itemCount: logic.histories.length,
                    itemBuilder: (_, index) => _buildMemberCard(
                      logic.histories[index],
                    ),
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

Widget _teamHeader({String? teamSpendAmt, String? teamMembersCount}) =>
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Styles.defaultBtnBgClr,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  Globe.teamSpendAmt,
                  style: Styles.tsDefaultTxtClr14sp,
                ),
                6.verticalSpace,
                Text(
                  teamSpendAmt ?? '',
                  style: Styles.tsDefaultTxtClr14sp,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  Globe.teamMembersCount,
                  style: Styles.tsDefaultTxtClr14sp,
                ),
                6.verticalSpace,
                Text(
                  teamMembersCount ?? '',
                  style: Styles.tsDefaultTxtClr14sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget _buildMemberCard(Team teamInfo) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 6.h,
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Styles.c_E2F2D1,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    Globe.memberName,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                  6.horizontalSpace,
                  Text(
                    teamInfo.name ?? '',
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ],
              ),
              6.verticalSpace,
              Row(
                children: [
                  Text(
                    Globe.account,
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                  6.horizontalSpace,
                  Text(
                    teamInfo.phone ?? '',
                    style: Styles.tsDefaultTxtClr14sp,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: false, // (teamInfo.totalChild ?? 0) >= 1,
            child: Row(
              children: [
                Text(
                  "${teamInfo.totalChild}",
                  style: Styles.tsDefaultTxtClr14sp,
                ),
                6.horizontalSpace,
                ImageStr.icGreyNext.toImage
                  ..width = 25.w
                  ..height = 25.h,
              ],
            ),
          )
        ],
      ),
    ),
  );
}
