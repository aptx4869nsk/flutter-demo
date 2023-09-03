import 'package:kaibo/utils/enums.dart';

class ApiResp implements Exception {
  String? status;
  String? message;
  dynamic data;
  dynamic errors;
  bool? success;
  ApiErrType? type;

  ApiResp({
    this.status,
    this.message,
    this.data,
    this.errors,
    this.success,
    this.type,
  });

  ApiErrType get getApiRespErrType => type ?? ApiErrType.respErr;

  ApiResp.fromJson(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"],
        errors = map["errors"],
        success = map["success"],
        type = map['type'];

}
