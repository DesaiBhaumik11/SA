
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';

class ProductVarientDetailModel
{
  List<ProductDetailsModel> ProductDetail;

  String Id;

  ProductVarientDetailModel({
    this.ProductDetail,
    this.Id,
  });

  factory ProductVarientDetailModel.fromJson(Map<String, dynamic> parsedData) {
    return ProductVarientDetailModel(
      ProductDetail: parsedData['ProductDetail'] != null ? ProductDetailsModel.parseList(parsedData['ProductDetail']) : null,
      Id: parsedData['Id'],
    );
  }

  static List<ProductVarientDetailModel> parseList(listData) {
    var list = listData as List;
    List<ProductVarientDetailModel> jobList =
    list.map((data) => ProductVarientDetailModel.fromJson(data)).toList();
    return jobList;
  }
}