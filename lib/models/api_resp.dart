import 'package:kaibo/utils/enums.dart';

class ApiResp implements Exception {
  int? code;
  bool? success;
  String? message;
  dynamic data;
  dynamic errors;
  ApiErrType? type;

  ApiResp({
    this.code,
    this.message,
    this.data,
    this.errors,
    this.success,
    this.type,
  });

  ApiErrType get getApiRespErrType => type ?? ApiErrType.respErr;

  ApiResp.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        success = map["success"],
        message = map["message"],
        data = map["data"],
        errors = map["errors"],
        type = map['type'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data["success"] = success;
    data['message'] = message;
    data['data'] = data;
    data['errors'] = errors;
    data['type'] = type;
    return data;
  }
}
