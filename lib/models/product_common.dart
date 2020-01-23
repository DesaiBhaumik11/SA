// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromMap(json.decode(str));

String resultToJson(Result data) => json.encode(data.toMap());



class Result {
  String name;
  String description;
  double price;
  String unit;
  String categoryId;
  String productVariantId;
  String productVariantGroupId;
  String productMediaId;
  double offer;
  String id;
  String brandId;
  double discountPercent;
  String seoTag;
  int quantity;
  double OfferPrice;
  List<ProductExtraField> productExtraFields =List() ;
  List<ProductVariantAttributeGroups> varientGroupList = List();

  Result({
    this.name,
    this.description,
    this.price,
    this.unit,
    this.categoryId,
    this.productVariantId,
    this.productVariantGroupId,
    this.productMediaId,
    this.offer,
    this.id,
    this.brandId,
    this.discountPercent,
    this.seoTag,
    this.quantity,
    this.productExtraFields,
    this.OfferPrice,
    this.varientGroupList,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    name: json["Name"],
    description: json["Description"],
    price: json["Price"],
    unit: json["Unit"],
    categoryId: json["CategoryId"],
    productVariantId: json["ProductVariantId"],
    productVariantGroupId: json["ProductVariantGroupId"],
    productMediaId: json["ProductMediaId"],
    offer: json["Offer"],
    id: json["Id"],
    brandId: json["BrandId"],
    discountPercent: json["DiscountPercent"],
    seoTag: json["SEOTag"],
    quantity: json["Quantity"],
    OfferPrice: json["OfferPrice"],
    productExtraFields: json["productExtraFields"] != null ? ProductExtraField.parseList(json["productExtraFields"]) : null,
    varientGroupList: json['ProductVariantAttributeGroups'] != null ?
        ProductVariantAttributeGroups.parseList(json['ProductVariantAttributeGroups']) : null
  );

  Map<String, dynamic> toMap() => {
    "Name": name,
    "Description": description,
    "Price": price,
    "Unit": unit,
    "CategoryId": categoryId,
    "ProductVariantId": productVariantId,
    "ProductVariantGroupId": productVariantGroupId,
    "ProductMediaId": productMediaId,
    "Offer": offer,
    "Id": id,
    "BrandId": brandId,
    "DiscountPercent": discountPercent,
    "SEOTag": seoTag,
    "Quantity": quantity,
    "OfferPrice": OfferPrice,
    "productExtraFields": List<dynamic>.from(productExtraFields.map((x) => x.toJson())),
  };


  static List<Result> parseList(listData) {
    var list = listData as List;
    List<Result> jobList =
    list.map((data) => Result.fromMap(data)).toList();
    return jobList;
  }
}




class ProductExtraField {
  String productId;
  String language;
  String title;
  String value;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductExtraField({
    this.productId,
    this.language,
    this.title,
    this.value,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductExtraField.fromJson(Map<String, dynamic> json) =>
      ProductExtraField(
        productId: json["ProductId"],
        language: json["Language"],
        title: json["Title"],
        value: json["Value"],
        updatedBy: json["UpdatedBy"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: json["UpdatedOn"],
      );

  Map<String, dynamic> toJson() =>
      {
        "ProductId": productId,
        "Language": language,
        "Title": title,
        "Value": value,
        "UpdatedBy": updatedBy,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedOn": updatedOn,
      };

  static List<ProductExtraField> parseList(listData) {
    var list = listData as List;
    List<ProductExtraField> jobList =
    list.map((data) => ProductExtraField.fromJson(data)).toList();
    return jobList;
  }
}

class ProductVariantAttributeGroups
{
  String GroupName;

  int DisplayOrder;

  String ProductId;

  ProductVariantAttributeGroups({
    this.ProductId,
    this.GroupName,
    this.DisplayOrder,
  });

  factory ProductVariantAttributeGroups.fromJson(Map<String,dynamic> parsedData) {
    return ProductVariantAttributeGroups(
      ProductId: parsedData['ProductId'],
      GroupName: parsedData['GroupName'],
      DisplayOrder: parsedData['DisplayOrder'],
    );
  }


  static List<ProductVariantAttributeGroups> parseList(listData) {
    var list = listData as List;
    List<ProductVariantAttributeGroups> jobList =
    list.map((data) => ProductVariantAttributeGroups.fromJson(data)).toList();
    return jobList;
  }
}