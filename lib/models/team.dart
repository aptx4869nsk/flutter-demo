class Teams {
  List<Team>? teams;
  Meta? meta;

  Teams({this.teams, this.meta});

  Teams.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      teams = <Team>[];
      json['teams'].forEach((v) {
        teams!.add(Team.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Team {
  int? id;
  String? name;
  String? phone;
  int? totalChild;

  Team({this.id, this.name, this.phone, this.totalChild});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    totalChild = json['totalChild'];
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
