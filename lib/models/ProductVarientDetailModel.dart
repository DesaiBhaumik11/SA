
import 'package:vegetos_flutter/models/ProductDetailsModel.dart';
import 'package:vegetos_flutter/models/ProductPriceModel.dart';
import 'package:vegetos_flutter/models/ProductVariantMedia.dart';

class ProductVarientDetailModel
{
  String Id;
  String ProductId;
  String PrimaryMediaId;
  bool IsDefault;
  bool IsActive;
  Object SubSku;
  int Status;
  Object ProductAttribute;

  List<ProductDetailsModel> ProductDetail;
  List<ProductVariantMedia> productVariantMedia;
  ProductPriceModel productPrice;

  ProductVarientDetailModel({
    this.Id,
    this.ProductId,
    this.PrimaryMediaId,
    this.IsDefault,
    this.IsActive,
    this.SubSku,
    this.Status,
    this.ProductAttribute,
    this.ProductDetail,
    this.productVariantMedia,
    this.productPrice
  });

  factory ProductVarientDetailModel.fromJson(Map<String, dynamic> parsedData) {
    return ProductVarientDetailModel(
      Id: parsedData['Id'],
        ProductId: parsedData['ProductId'] !=null ? parsedData['ProductId'] : "",
        PrimaryMediaId: parsedData['PrimaryMediaId'] ,
        IsDefault: parsedData['IsDefault'],
        IsActive: parsedData['IsActive'],
        SubSku: parsedData['SubSku'],
        Status: parsedData['Status'],
        ProductAttribute: parsedData['ProductAttribute'],
      ProductDetail: parsedData['ProductDetail'] != null ? ProductDetailsModel.parseList(parsedData['ProductDetail']) : new List(),
      productVariantMedia: parsedData['ProductVariantMedia'] != null ? ProductVariantMedia.parseList(parsedData['ProductVariantMedia']) : new List(),
      productPrice: parsedData['ProductPrice'] !=null ? ProductPriceModel.fromJson(parsedData['ProductPrice']) : new ProductPriceModel()
    );
  }

  static List<ProductVarientDetailModel> parseList(listData) {
    var list = listData as List;
    List<ProductVarientDetailModel> jobList =
    list.map((data) => ProductVarientDetailModel.fromJson(data)).toList();
    return jobList;
  }
}

