class DepositAddress {
  String? usdt;
  String? bsc;
  Bank? bank;
  String? depositNote;

  DepositAddress({this.usdt, this.bank, this.depositNote});

  DepositAddress.fromJson(Map<String, dynamic> json) {
    usdt = json['usdt'];
    bsc = json['bsc'];
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    depositNote = json['deposit_note'];
  }
}

class Bank {
  String? name;
  String? address;
  String? accName;
  String? accNumber;

  Bank({this.name, this.address, this.accName, this.accNumber});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    accName = json['accName'];
    accNumber = json['accNumber'];
  }
}
