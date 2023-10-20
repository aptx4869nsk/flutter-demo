import 'package:get/get.dart';
import 'package:kaibo/models/news_detail.dart';
import 'package:kaibo/utils/logger.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/pages/index/index_logic.dart';
import 'package:kaibo/apis.dart';

class NewsDetailLogic extends GetxController {
  final newsInfo = NewsDetail().obs;
  final indexLogic = Get.find<IndexLogic>();
  late int newsId;
  final enableNewsDetailShimmer = true.obs;

  @override
  void onInit() {
    newsId = Get.arguments['id'] ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    getNewsDetail();
    super.onReady();
  }

  void getNewsDetail() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      try {
        final data = await Apis.getNewsDetail(newsId: newsId);
        newsInfo.value = data;
        enableNewsDetailShimmer.value = false;
      } catch (e, s) {
        Logger.print('news detail e: $e $s');
      }
    });
  }
}
