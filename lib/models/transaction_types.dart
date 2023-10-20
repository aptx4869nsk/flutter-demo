class TransactionTypes {
  List<TransactionType>? transactionTypes;

  TransactionTypes({this.transactionTypes});

  TransactionTypes.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      transactionTypes = <TransactionType>[];
      json['types'].forEach((v) {
        transactionTypes!.add(TransactionType.fromJson(v));
      });
    }
  }
}

class TransactionType {
  String? code;
  String? name;

  TransactionType({this.code, this.name});

  TransactionType.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
}
