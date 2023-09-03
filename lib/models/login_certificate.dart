class LoginCertificate {
  String token;

  LoginCertificate.fromJson(Map<String, dynamic> map)
      : token = map["token"] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;

    return data;
  }
}
