class Profile {
  int? id;
  String? name;
  String? phone;
  String? inviteCode;
  String? profile;
  String? type;
  int? userType;
  int? isTeamLeader;
  int? isSpecialist;
  int? isSecondaryLeader;
  String? balance;
  String? canWithdrawBalance;
  String? totalEarn;
  String? teamPurchase;
  Card? card;
  Bank? bank;
  String? trcAddress;
  int? trcStatus;
  String? bscAddress;
  int? bscStatus;
  String? shippingPhone;
  String? shippingAddress;
  int? shippingAddressStatus;
  int? isWithdrawPasswordSet;
  String? createdAt;

  Profile(
      {this.id,
      this.name,
      this.phone,
      this.inviteCode,
      this.profile,
      this.type,
      this.userType,
      this.isTeamLeader,
      this.isSpecialist,
      this.isSecondaryLeader,
      this.balance,
      this.canWithdrawBalance,
      this.totalEarn,
      this.teamPurchase,
      this.card,
      this.bank,
      this.trcAddress,
      this.trcStatus,
      this.bscAddress,
      this.bscStatus,
      this.shippingPhone,
      this.shippingAddress,
      this.shippingAddressStatus,
      this.isWithdrawPasswordSet,
      this.createdAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    inviteCode = json['invite_code'];
    profile = json['profile'];
    type = json['type'];
    userType = json['user_type'];
    isTeamLeader = json['is_team_leader'];
    isSpecialist = json['is_specialist'];
    isSecondaryLeader = json['is_secondary_leader'];
    balance = json['balance'].toString();
    canWithdrawBalance = json['can_withdraw_balance'].toString();
    totalEarn = json['total_earn'].toString();
    teamPurchase = json['team_purchase'].toString();
    card = json['card'] != null ? Card.fromJson(json['card']) : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    trcAddress = json['trc_address'];
    trcStatus = json['trc_status'];
    bscAddress = json['bsc_address'];
    bscStatus = json['bsc_status'];
    shippingPhone = json['shipping_phone'];
    shippingAddress = json['shipping_address'];
    shippingAddressStatus = json['shipping_address_status'];
    isWithdrawPasswordSet = json['is_withdraw_password_set'];
    createdAt = json['createdAt'];
  }
}

class Card {
  String? name;
  String? number;
  String? front;
  String? back;
  int? status;

  Card({this.name, this.number, this.front, this.back, this.status});

  Card.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    front = json['front'];
    back = json['back'];
    status = json['status'];
  }
}

class Bank {
  String? code;
  String? name;
  String? address;
  String? cardName;
  String? cardNumber;
  int? status;

  Bank(
      {this.code,
      this.name,
      this.address,
      this.cardName,
      this.cardNumber,
      this.status});

  Bank.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    address = json['address'];
    cardName = json['card_name'];
    cardNumber = json['card_number'];
    status = json['status'];
  }
}
