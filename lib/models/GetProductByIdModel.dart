
import 'package:vegetos_flutter/models/DeleteThis.dart';

import 'ProductDetailsModel.dart';
import 'ProductPriceModel.dart';
import 'ProductTaxModel.dart';
import 'ProductVarientDetailModel.dart';
import 'UnitsModel.dart';

class GetProductByIdModel
{
  String ProductVariantId;

  String ProductId;

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

  List<ProductVarientDetailModel> ProductVariant;

  List<UnitsModel> Units;

  List<ProductDetailsModel> ProductDetails;

  ProductTaxModel ProductTax;

  Delete ProductPrice;

  Object ProductVariantMedia;

  GetProductByIdModel({
    this.ProductVariantId,
    this.ProductId,
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
    this.ProductVariant,
    this.Units,
    this.ProductDetails,
    this.ProductTax,
    this.ProductPrice,
    this.ProductVariantMedia,
  });

  factory GetProductByIdModel.fromJson(Map<String, dynamic> parsedData) {
    return GetProductByIdModel(
      ProductVariantId: parsedData['ProductVariantId'],
      ProductId: parsedData['Id'],
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
      ProductVariant: parsedData['ProductVariant'] != null ? ProductVarientDetailModel.parseList(parsedData['ProductVariant']) : null,
      Units: parsedData['Units'] != null ? UnitsModel.parseList(parsedData['Units']) : null,
      ProductDetails: parsedData['ProductDetails'] != null ? ProductDetailsModel.parseList(parsedData['ProductDetails']) : null,
      ProductTax: parsedData['ProductTax'] != null ? ProductTaxModel.fromJson(parsedData['ProductTax']) : null,
      ProductPrice: parsedData['ProductPrice'] != null ? Delete.fromJson(parsedData['ProductPrice']) : null,
      ProductVariantMedia: parsedData['ProductVariantMedia'],
    );
  }

  static List<GetProductByIdModel> parseList(listData) {
    var list = listData as List;
    List<GetProductByIdModel> jobList =
    list.map((data) => GetProductByIdModel.fromJson(data)).toList();
    return jobList;
  }
}