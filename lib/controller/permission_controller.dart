import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  @override
  void onInit() async {

    final permissions = [
      // Permission.systemAlertWindow,
      Permission.camera,
      Permission.storage,
      // Permission.microphone,
      // Permission.speech,
      // Permission.location,
      // Permission.notification,

      // Permission.bluetooth,
      // Permission.bluetoothConnect,
      // Permission.bluetoothAdvertise,
      // Permission.bluetoothScan,
    ];

    for (var permission in permissions) {
      final state = await permission.request();
    }
    super.onInit();
  }
}
