import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      this.id, 
      this.title, 
      this.price, 
      this.quantity, 
      this.total, 
      this.discountPercentage, 
      this.discountedPrice,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage'];
    discountedPrice = json['discountedPrice'];
  }
  num? id;
  String? title;
  num? price;
  num? quantity;
  num? total;
  num? discountPercentage;
  num? discountedPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['quantity'] = quantity;
    map['total'] = total;
    map['discountPercentage'] = discountPercentage;
    map['discountedPrice'] = discountedPrice;
    return map;
  }

}