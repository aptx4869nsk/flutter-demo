class Preload {
  Ad? ad;
  PopupAd? popupAd;
  CompanyInfo? companyInfo;
  List<String>? video;
  int? canBuy;
  int? canDeposit;
  int? canTransfer;
  String? usdtRate;
  String? withdrawalUsdtRate;
  String? trcWithdrawFee;
  String? withdrawalNote;
  TradeLimit? limit;
  TradeTime? depositTime;
  TradeTime? withdrawTime;
  Time? buyProductTime;
  String? filePath;
  List<int>? canViewMember;

  Preload(
      {this.ad,
        this.popupAd,
        this.video,
        this.canBuy,
        this.canDeposit,
        this.canTransfer,
        this.usdtRate,
        this.withdrawalUsdtRate,
        this.trcWithdrawFee,
        this.withdrawalNote,
        this.limit,
        this.depositTime,
        this.withdrawTime,
        this.buyProductTime,
        this.filePath,
        this.canViewMember});

  Preload.fromJson(Map<String, dynamic> json) {
    ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    popupAd = json['popup_ad'] != null
        ? PopupAd.fromJson(json['popup_ad'])
        : null;
    companyInfo = json['company_info'] != null
        ? CompanyInfo.fromJson(json['company_info'])
        : null;
    video = json['video'].cast<String>();
    canBuy = json['can_buy'];
    canDeposit = json['can_deposit'];
    canTransfer = json['can_transfer'];
    usdtRate = json['usdt_rate'];
    withdrawalUsdtRate = json['withdrawal_usdt_rate'];
    trcWithdrawFee = json['trc_withdraw_fee'];
    withdrawalNote = json['withdrawal_note'];
    limit = json['limit'] != null ? TradeLimit.fromJson(json['limit']) : null;
    depositTime = json['deposit_time'] != null
        ? TradeTime.fromJson(json['deposit_time'])
        : null;
    withdrawTime = json['withdraw_time'] != null
        ? TradeTime.fromJson(json['withdraw_time'])
        : null;
    buyProductTime = json['buy_product_time'] != null
        ? Time.fromJson(json['buy_product_time'])
        : null;
    filePath = json['file_path'];
    canViewMember = json['can_view_member'].cast<int>();
  }
}

class Ad {
  int? id;
  String? title;
  String? description;
  String? createdAt;

  Ad({this.id, this.title, this.description, this.createdAt});

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
  }
}

class PopupAd {
  String? title;
  String? body;
  int? status;

  PopupAd({this.title, this.body, this.status});

  PopupAd.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    status = json['status'];
  }
}

class CompanyInfo {
  String? title;
  String? body;

  CompanyInfo({this.title, this.body});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
}

class TradeLimit {
  TradeAmt? deposit;
  TradeAmt? withdraw;

  TradeLimit({this.deposit, this.withdraw});

  TradeLimit.fromJson(Map<String, dynamic> json) {
    deposit =
    json['deposit'] != null ? TradeAmt.fromJson(json['deposit']) : null;
    withdraw = json['withdraw'] != null
        ? TradeAmt.fromJson(json['withdraw'])
        : null;
  }
}

class TradeAmt {
  int? usdtMin;
  int? usdtMax;
  int? cnyMin;
  int? cnyMax;
  int? bscMin;
  int? bscMax;

  TradeAmt({this.usdtMin, this.usdtMax, this.cnyMin, this.cnyMax});

  TradeAmt.fromJson(Map<String, dynamic> json) {
    usdtMin = json['usdt_min'];
    usdtMax = json['usdt_max'];
    cnyMin = json['cny_min'];
    cnyMax = json['cny_max'];
    bscMin = json['bsc_min'];
    bscMax = json['bsc_max'];
  }
}

class TradeTime {
  Time? usdt;
  Time? cny;
  Time? bsc;

  TradeTime({this.usdt, this.cny,this.bsc});

  TradeTime.fromJson(Map<String, dynamic> json) {
    usdt = json['usdt'] != null ? Time.fromJson(json['usdt']) : null;
    cny = json['cny'] != null ? Time.fromJson(json['cny']) : null;
    bsc = json['bsc'] != null ? Time.fromJson(json['bsc']) : null;
  }
}

class Time {
  String? start;
  String? end;

  Time({this.start, this.end});

  Time.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }
}


