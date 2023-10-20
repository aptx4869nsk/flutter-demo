class RegisterSettings {
  int? canGetOtp;
  int? canRegister;

  RegisterSettings({
    this.canGetOtp,
    this.canRegister,
  });

  RegisterSettings.fromJson(Map<String, dynamic> json) {
    canGetOtp = json['can_get_otp'];
    canRegister = json['can_register'];
  }
}
