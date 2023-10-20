import 'package:get/get.dart';
import 'package:kaibo/models/news_detail.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/models/history.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/routes/app_navigator.dart';

class NewsLogic extends GetxController {
  final page = 1.obs;
  final pageSize = Get.find<IndexLogic>().pageSize;
  final appLogic = Get.find<AppController>();
  final oss = Get.find<IndexLogic>().preload.value.filePath ?? '';
  final newsInfo = NewsDetail().obs;
  final controller = RefreshController();
  final histories = <NewsHistory>[].obs;

  @override
  void onReady() {
    getNewsHistories();
    super.onReady();
  }

  // 下拉刷新
  void onLoading() async {
    page.value = page.value + 1;
    try {
      var data = await Apis.getNewsHistories(
        page: page.value,
        pageSize: pageSize,
      );
      var lst = data.histories ?? [];
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
      Logger.print('news e: $e $s');
    }
  }

  // 新闻详情
  void newsDetail(int newsId) => AppNavigator.startNewsDetail(id: newsId);

  /// 获取新闻记录
  void getNewsHistories() async {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        NewsHistories data = await Apis.getNewsHistories(
          page: page.value,
          pageSize: pageSize,
        );
        histories.value = data.histories ?? [];
      } catch (e, s) {
        Logger.print('news e: $e $s');
      }
    });
  }
}
