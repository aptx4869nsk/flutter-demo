class NewsHistories {
  List<NewsHistory>? histories;
  Meta? meta;

  NewsHistories({this.histories, this.meta});

  NewsHistories.fromJson(Map<String, dynamic> json) {
    if (json['histories'] != null) {
      histories = <NewsHistory>[];
      json['histories'].forEach((v) {
        histories!.add(NewsHistory.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class NewsHistory {
  int? id;
  String? title;
  String? image;
  String? createdAt;

  NewsHistory({this.id, this.title, this.image, this.createdAt});

  NewsHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['createdAt'];
  }
}

class DepositWithdrawalHistories {
  List<DepositWithdrawalHistory>? histories;
  Meta? meta;

  DepositWithdrawalHistories({this.histories, this.meta});

  DepositWithdrawalHistories.fromJson(Map<String, dynamic> json) {
    if (json['histories'] != null) {
      histories = <DepositWithdrawalHistory>[];
      json['histories'].forEach((v) {
        histories!.add(DepositWithdrawalHistory.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class DepositWithdrawalHistory {
  int? id;
  int? amount;
  int? currency;
  int? status;
  String? description;
  String? createdAt;

  DepositWithdrawalHistory({
    this.id,
    this.amount,
    this.currency,
    this.status,
    this.description,
    this.createdAt,
  });

  DepositWithdrawalHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    description = json['description'];
    createdAt = json['createdAt'];
  }
}

class TransactionHistories {
  List<TransactionHistory>? histories;
  Meta? meta;

  TransactionHistories({this.histories, this.meta});

  TransactionHistories.fromJson(Map<String, dynamic> json) {
    if (json['histories'] != null) {
      histories = <TransactionHistory>[];
      json['histories'].forEach((v) {
        histories!.add(TransactionHistory.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class TransactionHistory {
  int? id;
  String? amount;
  String? type;
  int? isChildPay;
  String? createdAt;
  EffectUser? effectUser;

  TransactionHistory({
    this.id,
    this.amount,
    this.type,
    this.isChildPay,
    this.createdAt,
    this.effectUser,
  });

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'].toString();
    type = json['type'];
    isChildPay = json['is_child_pay'];
    createdAt = json['createdAt'];
    effectUser = json['effectUser'] != null
        ? EffectUser.fromJson(json['effectUser'])
        : null;
  }
}

class EffectUser {
  int? id;
  String? name;
  String? phone;

  EffectUser({this.id, this.name, this.phone});

  EffectUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }
}

class OrderHistories {
  List<OrderHistory>? histories;
  Meta? meta;

  OrderHistories({this.histories, this.meta});

  OrderHistories.fromJson(Map<String, dynamic> json) {
    if (json['histories'] != null) {
      histories = <OrderHistory>[];
      json['histories'].forEach((v) {
        histories!.add(OrderHistory.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class OrderHistory {
  int? id;
  int? price;
  double? earnRate;
  String? startTime;
  String? endTime;
  int? status;
  int? orderedBy;
  OrderProduct? product;

  OrderHistory({
    this.id,
    this.price,
    this.earnRate,
    this.startTime,
    this.endTime,
    this.status,
    this.orderedBy,
    this.product,
  });

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    earnRate = json['earn_rate'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    orderedBy = json['orderedBy'];
    product =
        json['product'] != null ? OrderProduct.fromJson(json['product']) : null;
  }
}

class OrderProduct {
  int? id;
  String? name;
  String? image;

  OrderProduct({this.id, this.name, this.image});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Meta {
  int? page;
  int? perPage;
  int? totalPage;
  int? total;

  Meta({this.page, this.perPage, this.totalPage, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    totalPage = json['totalPage'];
    total = json['total'];
  }
}
