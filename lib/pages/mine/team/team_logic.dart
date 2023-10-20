import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/models/team.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class TeamLogic extends GetxController {
  final page = 1.obs;
  final indexLogic = Get.find<IndexLogic>();
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final histories = <Team>[].obs;
  final teamsEarn = ''.obs;
  final totalCount = 0.obs;

  @override
  void onInit() {
    teamsEarn.value = indexLogic.profile.value.teamPurchase ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    getTeams();
    super.onReady();
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getTeams(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.teams ?? [];
      if (lst.isEmpty) {
        page.value = page.value - 1;
        controller.loadNoData();
      } else {
        histories.addAll(lst);
        if (lst.length < pageSize) {
          controller.loadNoData();
        } else {
          controller.loadComplete();
        }
      }
    } catch (e, s) {
      page.value = page.value - 1;
      controller.loadFailed();
      Logger.print('team e: $e $s');
    }
  }

  // 获取充值记录
  void getTeams() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        Teams data = await Apis.getTeams(
          page: page.value,
          pageSize: pageSize,
        );
        histories.value = data.teams ?? [];
        totalCount.value = data.meta?.total ?? 0;
      } catch (e, s) {
        Logger.print('team e: $e $s');
      }
    });
  }
}
