import 'package:get/get.dart';
import 'package:kaibo/pages/splash/splash_binding.dart';
import 'package:kaibo/pages/splash/splash_view.dart';
import 'package:kaibo/pages/index/index_binding.dart';
import 'package:kaibo/pages/index/index_view.dart';

part 'app_routes.dart';

class AppPages {
  /// 左滑关闭页面用于android
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    // Splash
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    // home
    _pageBuilder(
      name: AppRoutes.home,
      page: () => IndexPage(),
      binding: IndexBinding(),
    ),
  ];
}
