class SupportedBanks {
  List<SupportedBank>? supportedBanks;

  SupportedBanks({this.supportedBanks});

  SupportedBanks.fromJson(Map<String, dynamic> json) {
    if (json['banks'] != null) {
      supportedBanks = <SupportedBank>[];
      json['banks'].forEach((v) {
        supportedBanks!.add(SupportedBank.fromJson(v));
      });
    }
  }
}

class SupportedBank {
  String? code;
  String? name;

  SupportedBank({this.code, this.name});

  SupportedBank.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
}
