// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel extends ChangeNotifier{
  List<Result> result;
  String version;
  int statusCode;
  String message;
  bool isError;

  bool search=false;

  SearchModel({
    this.result,
    this.version,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    version: json["Version"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "Version": version,
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };


  searchProducts(s){
    NetworkUtils.getRequest(endPoint: Constant.SearchProduct + "$s").then((r){
      print("Best selling product response = $r");
      setData(json.decode(r));
    }).catchError((e) {
      print("Error caught in search $e");
    });
  }

  void setData(json) {
    result= List<Result>.from(json["Result"].map((x) => Result.fromJson(x))) ;
    version= json["Version"];
    statusCode= json["StatusCode"];
    message= json["Message"];
    isError= json["IsError"];
    notifyListeners();
  }

  void searching(bool param0) {
      search=param0;
    notifyListeners();
  }


}

class Result {
  String productVariantId;
  String productId;
  String primaryMediaId;
  bool isDefault;
  String categoryId;
  String manufacturerId;
  String brandId;
  String seoTags;
  bool isActive;
  String categoryName;
  String categoryParentId;
  String categoryMediaId;
  String manufacturerName;
  String brandName;
  List<Unit> units;
  dynamic tags;
  List<ProductExtraField> productExtraFields;
  dynamic productVariantAttributeGroups;
  dynamic productAttributes;
  List<ProductDetail> productDetails;
  List<String> productVariantMedia;
  ProductTax productTax;
  ProductPrice productPrice;

  Result({
    this.productVariantId,
    this.productId,
    this.primaryMediaId,
    this.isDefault,
    this.categoryId,
    this.manufacturerId,
    this.brandId,
    this.seoTags,
    this.isActive,
    this.categoryName,
    this.categoryParentId,
    this.categoryMediaId,
    this.manufacturerName,
    this.brandName,
    this.units,
    this.tags,
    this.productExtraFields,
    this.productVariantAttributeGroups,
    this.productAttributes,
    this.productDetails,
    this.productVariantMedia,
    this.productTax,
    this.productPrice,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    productVariantId: json["ProductVariantId"],
    productId: json["ProductId"],
    primaryMediaId: json["PrimaryMediaId"],
    isDefault: json["IsDefault"],
    categoryId: json["CategoryId"],
    manufacturerId: json["ManufacturerId"],
    brandId: json["BrandId"],
    seoTags: json["SeoTags"],
    isActive: json["IsActive"],
    categoryName: json["CategoryName"],
    categoryParentId: json["CategoryParentId"],
    categoryMediaId: json["CategoryMediaId"],
    manufacturerName: json["ManufacturerName"],
    brandName: json["BrandName"],
    units: List<Unit>.from(json["Units"].map((x) => Unit.fromJson(x))),
    tags: json["Tags"],
    productExtraFields: List<ProductExtraField>.from(json["ProductExtraFields"].map((x) => ProductExtraField.fromJson(x))),
    productVariantAttributeGroups: json["ProductVariantAttributeGroups"],
    productAttributes: json["ProductAttributes"],
    productDetails: List<ProductDetail>.from(json["ProductDetails"].map((x) => ProductDetail.fromJson(x))),
    productVariantMedia: List<String>.from(json["ProductVariantMedia"].map((x) => x)),
    productTax: ProductTax.fromJson(json["ProductTax"]),
    productPrice: ProductPrice.fromJson(json["ProductPrice"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductVariantId": productVariantId,
    "ProductId": productId,
    "PrimaryMediaId": primaryMediaId,
    "IsDefault": isDefault,
    "CategoryId": categoryId,
    "ManufacturerId": manufacturerId,
    "BrandId": brandId,
    "SeoTags": seoTags,
    "IsActive": isActive,
    "CategoryName": categoryName,
    "CategoryParentId": categoryParentId,
    "CategoryMediaId": categoryMediaId,
    "ManufacturerName": manufacturerName,
    "BrandName": brandName,
    "Units": List<dynamic>.from(units.map((x) => x.toJson())),
    "Tags": tags,
    "ProductExtraFields": List<dynamic>.from(productExtraFields.map((x) => x.toJson())),
    "ProductVariantAttributeGroups": productVariantAttributeGroups,
    "ProductAttributes": productAttributes,
    "ProductDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "ProductVariantMedia": List<dynamic>.from(productVariantMedia.map((x) => x)),
    "ProductTax": productTax.toJson(),
    "ProductPrice": productPrice.toJson(),
  };
}

class ProductDetail {
  String language;
  String name;
  String summary;
  String description;

  ProductDetail({
    this.language,
    this.name,
    this.summary,
    this.description,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    language: json["Language"],
    name: json["Name"],
    summary: json["Summary"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Language": language,
    "Name": name,
    "Summary": summary,
    "Description": description,
  };
}

class ProductExtraField {
  String language;
  String title;
  String value;

  ProductExtraField({
    this.language,
    this.title,
    this.value,
  });

  factory ProductExtraField.fromJson(Map<String, dynamic> json) => ProductExtraField(
    language: json["Language"],
    title: json["Title"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Language": language,
    "Title": title,
    "Value": value,
  };
}

class ProductPrice {
  String productId;
  String productVariantId;
  DateTime applicableFrom;
  bool isTaxInclusive;
  String businessLocationId;
  double price;
  double discountPercent;
  double offerPrice;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductPrice({
    this.productId,
    this.productVariantId,
    this.applicableFrom,
    this.isTaxInclusive,
    this.businessLocationId,
    this.price,
    this.discountPercent,
    this.offerPrice,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    productId: json["ProductId"],
    productVariantId: json["ProductVariantId"],
    applicableFrom: DateTime.parse(json["ApplicableFrom"]),
    isTaxInclusive: json["IsTaxInclusive"],
    businessLocationId: json["BusinessLocationId"],
    price: json["Price"],
    discountPercent: json["DiscountPercent"],
    offerPrice: json["OfferPrice"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductVariantId": productVariantId,
    "ApplicableFrom": applicableFrom.toIso8601String(),
    "IsTaxInclusive": isTaxInclusive,
    "BusinessLocationId": businessLocationId,
    "Price": price,
    "DiscountPercent": discountPercent,
    "OfferPrice": offerPrice,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class ProductTax {
  String productId;
  String taxId;
  DateTime startDate;
  DateTime endDate;
  Tax tax;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  ProductTax({
    this.productId,
    this.taxId,
    this.startDate,
    this.endDate,
    this.tax,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductTax.fromJson(Map<String, dynamic> json) => ProductTax(
    productId: json["ProductId"],
    taxId: json["TaxId"],
    startDate: DateTime.parse(json["StartDate"]),
    endDate: DateTime.parse(json["EndDate"]),
    tax: Tax.fromJson(json["Tax"]),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "TaxId": taxId,
    "StartDate": startDate.toIso8601String(),
    "EndDate": endDate.toIso8601String(),
    "Tax": tax.toJson(),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn.toIso8601String(),
  };
}

class Tax {
  String id;
  String name;
  double rate;
  dynamic parentId;
  dynamic baseTax;
  List<dynamic> taxes;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  Tax({
    this.id,
    this.name,
    this.rate,
    this.parentId,
    this.baseTax,
    this.taxes,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["Id"],
    name: json["Name"],
    rate: json["Rate"],
    parentId: json["ParentId"],
    baseTax: json["BaseTax"],
    taxes: List<dynamic>.from(json["Taxes"].map((x) => x)),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Rate": rate,
    "ParentId": parentId,
    "BaseTax": baseTax,
    "Taxes": List<dynamic>.from(taxes.map((x) => x)),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class Unit {
  String unitId;
  String baseUnitId;
  double baseUnitMultiplier;
  int decimalPlaces;
  String language;
  String code;
  String name;

  Unit({
    this.unitId,
    this.baseUnitId,
    this.baseUnitMultiplier,
    this.decimalPlaces,
    this.language,
    this.code,
    this.name,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    unitId: json["UnitId"],
    baseUnitId: json["BaseUnitId"],
    baseUnitMultiplier: json["BaseUnitMultiplier"],
    decimalPlaces: json["DecimalPlaces"],
    language: json["Language"],
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "UnitId": unitId,
    "BaseUnitId": baseUnitId,
    "BaseUnitMultiplier": baseUnitMultiplier,
    "DecimalPlaces": decimalPlaces,
    "Language": language,
    "Code": code,
    "Name": name,
  };
}
