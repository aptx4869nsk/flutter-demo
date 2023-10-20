class Products {
  List<Product>? products;
  Meta? meta;

  Products({this.products, this.meta});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Product {
  int? id;
  String? name;
  int? minPrice;
  int? maxPrice;
  int? duration;
  double? earnRate;
  int? buyLimit;
  String? image;
  int? status;
  String? description;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.name,
        this.minPrice,
        this.maxPrice,
        this.duration,
        this.earnRate,
        this.buyLimit,
        this.image,
        this.status,
        this.description,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    duration = json['duration'];
    earnRate = json['earn_rate'];
    buyLimit = json['buy_limit'];
    image = json['image'];
    status = json['status'];
    description = json['description'];
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
