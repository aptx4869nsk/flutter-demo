class NewsDetail {
  int? id;
  String? title;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;

  NewsDetail(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.createdAt,
        this.updatedAt});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
