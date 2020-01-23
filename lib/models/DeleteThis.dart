

import 'ProductDetailsModel.dart';
import 'ProductPriceModel.dart';
import 'ProductTaxModel.dart';
import 'ProductVarientDetailModel.dart';
import 'UnitsModel.dart';
import 'DeleteThis.dart' as delete;

class Delete
{
  delete.Result Result;

  Delete({
    this.Result
  });

  factory Delete.fromJson(Map<String, dynamic> parsedData) {
    return Delete(
      Result: parsedData['Result'] != null ? delete.Result.fromJson(parsedData['Result']) : null,
    );
  }
}

class Result
{
  String ProductId;

  String ProductVariantId;

  String ApplicableFrom;

  bool IsTaxInclusive;

  String BusinessLocationId;

  double Price;

  double DiscountPercent;

  double OfferPrice;

  String UpdatedBy;

  String CreatedBy;

  String CreatedOn;

  String UpdatedOn;

  Result({
    this.ProductId,
    this.ProductVariantId,
    this.ApplicableFrom,
    this.IsTaxInclusive,
    this.BusinessLocationId,
    this.Price,
    this.DiscountPercent,
    this.OfferPrice,
    this.UpdatedBy,
    this.CreatedBy,
    this.CreatedOn,
    this.UpdatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> parsedData) {
    return Result(
      ProductId: parsedData['ProductId'],
      ProductVariantId: parsedData['ProductVariantId'],
      ApplicableFrom: parsedData['ApplicableFrom'],
      IsTaxInclusive: parsedData['IsTaxInclusive'],
      BusinessLocationId: parsedData['BusinessLocationId'],
      Price: parsedData['Price'],
      DiscountPercent: parsedData['DiscountPercent'],
      OfferPrice: parsedData['OfferPrice'],
      UpdatedBy: parsedData['UpdatedBy'],
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
      UpdatedOn: parsedData['UpdatedOn'],
    );
  }
}