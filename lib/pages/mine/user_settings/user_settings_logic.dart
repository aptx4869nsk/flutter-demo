import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/widgets/custom_dialog.dart';
import 'package:kaibo/routes/app_navigator.dart';
import 'package:kaibo/views/loading_view.dart';
import 'package:kaibo/utils/data_sp.dart';
import 'package:kaibo/widgets/app_widget.dart';
import 'package:kaibo/pages/index/index_logic.dart';

class UserSettingsLogic extends GetxController {
  final indexLogic = Get.find<IndexLogic>();
  final isWithdrawalPwdSet = false.obs;

  @override
  void onInit() {
    isWithdrawalPwdSet.value =
        indexLogic.profile.value.isWithdrawPasswordSet == 1 ? true : false;
    super.onInit();
  }

  void modifyPhone() => AppNavigator.startModifyPhone();

  void modifyLoginPwd() => AppNavigator.startModifyLoginPwd();

  void modifyBillingAddr() => AppNavigator.startModifyBillingAddr();

  void modifyWithdrawalPwd() => AppNavigator.startModifyWithdrawalPwd();

  void safetyLogout() async {
    var confirm = await Get.dialog(CustomDialog(
      title: Globe.logoutHint,
    ));
    if (confirm == true) {
      try {
        await LoadingView.singleton.wrap(asyncFunction: () async {
          await DataSp.removeLoginCertificate();
        });
        AppNavigator.startLogin();
      } catch (e) {
        AppWidget.showToast('e:$e');
      }
    }
  }
}
