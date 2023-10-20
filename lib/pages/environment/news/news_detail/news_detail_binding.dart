import 'package:get/get.dart';
import 'news_detail_logic.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsDetailLogic());
  }
}
