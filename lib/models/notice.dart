class Notices {
  List<Notice>? notifications;
  Meta? meta;

  Notices({this.notifications, this.meta});

  Notices.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notice>[];
      json['notifications'].forEach((v) {
        notifications!.add( Notice.fromJson(v));
      });
    }
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }
}

class Notice {
  int? id;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  Notice(
      {this.id,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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