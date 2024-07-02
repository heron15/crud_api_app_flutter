import 'package:crud_operation_flutter/data/model/product_model.dart';

class ProductWrapperModel {
  String? status;
  List<ProductModel>? productList;

  ProductWrapperModel({this.status, this.productList});

  ProductWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach(
        (v) {
          productList!.add(ProductModel.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (productList != null) {
      data['data'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
