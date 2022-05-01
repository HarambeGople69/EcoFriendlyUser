import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';
@HiveType(typeId: 1)

class ProductModalClass {
  @HiveField(0)

  String? categoryname;
  @HiveField(1)

  String? productname;
  @HiveField(2)

  String? listprice;
  @HiveField(3)
  
  String? description;

  ProductModalClass(
      {this.categoryname, this.productname, this.listprice, this.description});

  ProductModalClass.fromJson(Map<String, dynamic> json) {
    categoryname = json['categoryname'];
    productname = json['productname'];
    listprice = json['listprice'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryname'] = this.categoryname;
    data['productname'] = this.productname;
    data['listprice'] = this.listprice;
    data['description'] = this.description;
    return data;
  }
}