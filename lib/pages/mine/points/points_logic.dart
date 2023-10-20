import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/app_widget.dart';

class PointsLogic extends GetxController {

  void swapPoints() {
    AppWidget.showToast(Globe.checkInNot180Days);
  }

  void sellOutPoints() {
    AppWidget.showToast(Globe.haveNoPoints);
  }
}