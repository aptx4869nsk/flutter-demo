import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mini_store/resources/lang.dart';
import 'package:mini_store/routes/app_pages.dart';
import 'package:mini_store/utils/logger.dart';
import 'package:mini_store/views/app_view.dart';
import 'package:mini_store/controller/app_controller.dart';
import 'package:mini_store/controller/push_controller.dart';
import 'package:mini_store/controller/permission_controller.dart';

class mini_storeApp extends StatelessWidget {
  const mini_storeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      builder: (locale, builder) => RefreshConfiguration(
        hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          builder: builder,
          logWriterCallback: Logger.print,
          translations: TranslationService(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          fallbackLocale: TranslationService.fallbackLocale,
          localeResolutionCallback: (locale, list) {
            Get.locale ??= locale;
            return null;
          },
          supportedLocales: const [
            Locale('zh', 'CN'),
            Locale('en', 'US'),
          ],
          getPages: AppPages.routes,
          initialBinding: InitBinding(),
          initialRoute: AppRoutes.home,
        ),
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PermissionController>(PermissionController());
    Get.put<AppController>(AppController());
    // Get.put<PushController>(PushController());
  }
}
