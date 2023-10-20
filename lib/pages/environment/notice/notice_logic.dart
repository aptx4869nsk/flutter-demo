import 'package:get/get.dart';
import 'package:kaibo/models/notice.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/apis.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoticeLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final controller = RefreshController();
  final notices = <Notice>[].obs;

  @override
  void onReady() {
    getNotices();
    super.onReady();
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getNotices(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.notifications ?? [];
      if (lst.isEmpty) {
        page.value = page.value - 1;
        controller.loadNoData();
      } else {
        notices.addAll(lst);
        if (lst.length < pageSize) {
          controller.loadNoData();
        } else {
          controller.loadComplete();
        }
      }
    } catch (e, s) {
      page.value = page.value - 1;
      controller.loadFailed();
      Logger.print('notice e: $e $s');
    }
  }

  /// 获取公告
  void getNotices() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        Notices data = await Apis.getNotices(
          page: page.value,
          pageSize: pageSize,
        );
        notices.value = data.notifications ?? [];
      } catch (e, s) {
        Logger.print('notice e: $e $s');
      }
    });
  }
}
