part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const forgetPassword = '/forget_password';
  static const register = '/register';
  static const home = '/home';
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
