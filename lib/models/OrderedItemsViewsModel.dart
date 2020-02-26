
import 'package:vegetos_flutter/models/UnitsModel.dart';

import 'ProductDetailsModel.dart';
import 'ProductPriceModel.dart';
import 'ProductTaxModel.dart';

//created by Prashant on 08-01-2020
class OrderItemsViewModel
{

  double price;

//  String productVariantId;

  String productId;

  String brandId;

  String seoTags;

  double quantity;

  int minimumOrderQuantity;

  int incrementalStep;

  List<UnitsModel> units;

  List<ProductDetailsModel> productDetails;

  ProductTaxModel productTax;

  ProductPriceModel productPrice;
  double totalLineAmount;
  double taxAmount;

  List<String> productVariantMedia;

  int itemCount;

  OrderItemsViewModel({
    this.price,
//    this.productVariantId,
    this.productId,
    this.brandId,
    this.seoTags,
    this.quantity,
    this.minimumOrderQuantity,
    this.incrementalStep,
    this.units,
    this.productDetails,
    this.productTax,
    this.productPrice,
    this.totalLineAmount,
    this.taxAmount,
    this.productVariantMedia,
    this.itemCount
  });

  factory OrderItemsViewModel.fromJson(Map<String, dynamic> parsedData) {
    var ProductMediaIds = parsedData['ProductMediaIds'];
    return OrderItemsViewModel(
      price: parsedData['Price'],
//      productVariantId: parsedData['ProductVariantId'],
      productId: parsedData['ProductId'],
      brandId: parsedData['BrandId'],
      seoTags: parsedData['SeoTags'],
      quantity: parsedData['Quantity'] !=null ? parsedData['Quantity'] : 0,
      minimumOrderQuantity: parsedData['MinimumOrderQuantity'] !=null ?parsedData['MinimumOrderQuantity'] : 0,
      incrementalStep: parsedData['IncrementalStep'],
      units: parsedData['Units'] != null ? UnitsModel.parseList(parsedData['Units']) : null,
      productDetails: parsedData['ProductDetails'] != null ? ProductDetailsModel.parseList(parsedData['ProductDetails']) : null,
      productTax: parsedData['ProductTax'] != null ? ProductTaxModel.fromJson(parsedData['ProductTax']) : null,
      totalLineAmount: parsedData['TotalLineAmount'] !=null ? parsedData['TotalLineAmount'] : 0,
      taxAmount: parsedData['TaxAmount'] !=null ? parsedData['TaxAmount'] : 0,
      productPrice: parsedData['ProductPrice'] != null ? ProductPriceModel.fromJson(parsedData['ProductPrice']) : null,
      productVariantMedia: ProductMediaIds!=null  ? new List<String>.from(ProductMediaIds) : null ,//json["ProductVariantMedia"] :json["ProductMediaId"],
      itemCount: parsedData['ItemCount'],
    );
  }

  static List<OrderItemsViewModel> parseList(listData) {
    var list = listData as List;
    List<OrderItemsViewModel> jobList =
    list.map((data) => OrderItemsViewModel.fromJson(data)).toList();
    return jobList;
  }
  static List<String> parseListString(listData) {
    var list = listData as List;
    List<String> jobList =
    list.map((data) => data.toList());
    return jobList;
  }

}