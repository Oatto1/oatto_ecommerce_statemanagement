class SelectCart {
  String? uuid;
  String? productName;
  String? desc;
  int? productCount;
  double? productPrice;
  String? productImg;
  String? createdAt;
  bool? check = false;
  int? valcount;

  SelectCart(
      {this.uuid,
      this.productName,
      this.desc,
      this.productCount,
      this.productPrice,
      this.productImg,
      this.createdAt,
      this.check,
      this.valcount});

  SelectCart.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productName = json['productName'];
    desc = json['desc'];
    productCount = json['productCount'];
    productPrice = json['productPrice'];
    productImg = json['productImg'];
    createdAt = json['created_at'];
    check = json['check'] ?? false;
    valcount = json['valcount'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['productName'] = productName;
    data['desc'] = desc;
    data['productCount'] = productCount;
    data['productPrice'] = productPrice;
    data['productImg'] = productImg;
    data['created_at'] = createdAt;
    data['check'] = check;
    data['valcount'] = valcount;
    return data;
  }
}
