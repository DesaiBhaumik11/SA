
//created by Prashant on 08-01-2020
class ProductPriceModel {

  String ProductId;

  String ProductVariantId;

  String ApplicableFrom;

  bool IsTaxInclusive;

  String BusinessLocationId;

  double Price;

  double DiscountPercent;

  String DiscountString;

  double OfferPrice;

  String UpdatedBy;

  String CreatedBy;

  String CreatedOn;

  String UpdatedOn;

  ProductPriceModel({

    this.ProductId="",
    this.ProductVariantId="",
    this.ApplicableFrom="",
    this.IsTaxInclusive=false,
    this.BusinessLocationId="",
    this.Price=0,
    this.DiscountPercent=0,
    this.OfferPrice=0,
    this.UpdatedBy="",
    this.CreatedBy="",
    this.CreatedOn="",
    this.UpdatedOn="",
    this.DiscountString="",

  });

  factory ProductPriceModel.fromJson(Map<String, dynamic> parsedData) {
    double discount = parsedData['DiscountPercent'] !=null ? parsedData['DiscountPercent'] : 0;

    bool isZeroDecimal = false;

    if(discount!=null && discount!= 0 && discount.toString().split(".")[1]=="0"){
      isZeroDecimal = true;
    }

    return ProductPriceModel(
      ProductId: parsedData['ProductId'],
      ProductVariantId: parsedData['ProductVariantId'],
      ApplicableFrom: parsedData['ApplicableFrom'],
      IsTaxInclusive: parsedData['IsTaxInclusive'],
      BusinessLocationId: parsedData['BusinessLocationId'],
      Price: parsedData['Price']!=null ? parsedData['Price'] : 0,
      DiscountPercent: parsedData['DiscountPercent'],
      DiscountString: isZeroDecimal ? discount.round().toString() : discount.toString(),
      OfferPrice: parsedData['OfferPrice'] != null ? parsedData['OfferPrice'] : 0,
      UpdatedBy: parsedData['UpdatedBy'],
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
      UpdatedOn: parsedData['UpdatedOn'],

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