import 'package:get/get.dart';

class IndexLogic extends GetxController {
  // 0：首页，1：行情，2：合约，3：锁仓挖矿，4：资产
  var index = 0.obs;

  // 切换 Navigation Bottom Bar
  void switchTab(int i) {
    index.value = i;
  }
}
