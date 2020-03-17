
import 'package:vegetos_flutter/models/UnitsModel.dart';

import 'ProductDetailsModel.dart';
import 'ProductPriceModel.dart';
import 'ProductTaxModel.dart';

//created by Prashant on 08-01-2020
class ProductWithDefaultVarientModel {

  String ProductVariantId;
  String ProductId;
  String PrimaryMediaId;
  bool IsDefault;
  String CategoryId;
  String BrandId;
  String SeoTags;
  bool IsActive;
  String CategoryName;
  String CategoryParentId;
  String BrandName;
  int MinimumOrderQuantity;
  int IncrementalStep;
  List<UnitsModel> Units;
  List<ProductDetailsModel> ProductDetails;
  ProductTaxModel ProductTax;
  ProductPriceModel ProductPrice;
  Object ProductVariantMedia;

  String itemId;
  ProductWithDefaultVarientModel({
    this.ProductVariantId,
    this.ProductId,
    this.PrimaryMediaId,
    this.IsDefault,
    this.CategoryId,
    this.BrandId,
    this.SeoTags,
    this.IsActive,
    this.CategoryName,
    this.CategoryParentId,
    this.BrandName,
    this.MinimumOrderQuantity,
    this.IncrementalStep,
    this.Units,
    this.ProductDetails,
    this.ProductTax,
    this.ProductPrice,
    this.ProductVariantMedia,
  });

  factory ProductWithDefaultVarientModel.fromJson(Map<String, dynamic> parsedData) {
    return ProductWithDefaultVarientModel(
      ProductVariantId: parsedData['ProductVariantId'],
      ProductId: parsedData['Id'],
      PrimaryMediaId: parsedData['PrimaryMediaId'],
      IsDefault: parsedData['IsDefault'],
      CategoryId: parsedData['CategoryId'],
      BrandId: parsedData['BrandId'],
      SeoTags: parsedData['SeoTags'],
      IsActive: parsedData['IsActive'],
      CategoryName: parsedData['CategoryName'],
      CategoryParentId: parsedData['CategoryParentId'],
      BrandName: parsedData['BrandName'],
      MinimumOrderQuantity: parsedData['MinimumOrderQuantity'],
      IncrementalStep: parsedData['IncrementalStep'],
      Units: parsedData['Units'] != null ? UnitsModel.parseList(parsedData['Units']) : null,
      ProductDetails: parsedData['ProductDetails'] != null ? ProductDetailsModel.parseList(parsedData['ProductDetails']) : null,
      ProductTax: parsedData['ProductTax'] != null ? ProductTaxModel.fromJson(parsedData['ProductTax']) : new ProductTaxModel(),
      ProductPrice: parsedData['ProductPrice'] != null ? ProductPriceModel.fromJson(parsedData['ProductPrice']) : new ProductPriceModel(),
      ProductVariantMedia: parsedData['ProductVariantMedia'],
    );
  }

  static List<ProductWithDefaultVarientModel> parseList(listData) {
    var list = listData as List;
    List<ProductWithDefaultVarientModel> jobList =
    list.map((data) => ProductWithDefaultVarientModel.fromJson(data)).toList();
    return jobList;
  }
}