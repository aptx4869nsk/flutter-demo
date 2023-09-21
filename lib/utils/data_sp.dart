import 'sp_util.dart';
import 'package:mini_store/models/login_certificate.dart';

class DataSp {
  static const _loginCertificate = 'loginCertificate';
  static const _loginAccount = 'loginAccount';
  static const _server = "server";
  static const _language = "language";
  static const _ignoreUpdate = 'ignoreUpdate';

  DataSp._();

  static init() async {
    await SpUtil().init();
  }

  static String? get userToken => getLoginCertificate()?.token;

  static Future<bool>? putLoginCertificate(LoginCertificate lc) {
    return SpUtil().putObject(_loginCertificate, lc);
  }

  static LoginCertificate? getLoginCertificate() {
    return SpUtil()
        .getObj(_loginCertificate, (v) => LoginCertificate.fromJson(v.cast()));
  }

  /// {
  ///   "phone"    :"",
  ///   "areaCode" :"",
  ///   "email"    :"",
  /// }
  static Future<bool>? putLoginAccount(Map map) {
    return SpUtil().putObject(_loginAccount, map);
  }

  static Map? getLoginAccount() {
    return SpUtil().getObject(_loginAccount);
  }

  static Future<bool>? putServerConfig(Map<String, String> config) {
    return SpUtil().putObject(_server, config);
  }

  static Map? getServerConfig() {
    return SpUtil().getObject(_server);
  }

  static Future<bool>? putLanguage(int index) {
    return SpUtil().putInt(_language, index);
  }

  static int? getLanguage() {
    return SpUtil().getInt(_language);
  }

  static Future<bool>? putIgnoreVersion(String version) {
    return SpUtil().putString(_ignoreUpdate, version);
  }

  static String? getIgnoreVersion() {
    return SpUtil().getString(_ignoreUpdate);
  }
}
