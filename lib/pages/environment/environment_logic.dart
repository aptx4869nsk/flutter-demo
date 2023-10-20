import 'package:get/get.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/apis.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EnvironmentLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final appLogic = Get.find<AppController>();
  final controller = RefreshController();

  // 公告
  void notification() => AppNavigator.startNotification();

  // 更多新闻
  void moreNews() => AppNavigator.startNews();

  // 新闻详情
  void newsDetail(int newsId) => AppNavigator.startNewsDetail(id: newsId);

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  void refreshData({bool init = false}) async {
    try {
      indexLogic.getPreload();
      indexLogic.getNewsHistories();
      controller.refreshCompleted();
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      controller.refreshFailed();
      Logger.print('mine e: $e $s');
    }
  }

  void checkIn() {
    if (indexLogic.profile.value.card?.status != 2) {
      AppWidget.showToast(Globe.plsVerifiedAcc);
      AppNavigator.startUserVerification();
      return;
    }
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final suc = await Apis.checkIn();
        if (suc) {
          AppWidget.showToast(Globe.checkInSuccess);
          return;
        }
      } catch (e, s) {
        Logger.print('environment e: $e $s');
      }
    });
  }
}
