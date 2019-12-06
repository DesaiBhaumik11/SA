import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

ProductDetailModal productDetailFromJson(String str) => ProductDetailModal.fromJson(json.decode(str));

String productDetailToJson(ProductDetailModal data) => json.encode(data.toJson());

class ProductDetailModal extends ChangeNotifier{
  Result result;
  int statusCode;
  String message;
  bool isError;

  bool loaded=false;
  bool _loading=false;

  ProductDetailModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory ProductDetailModal.fromJson(Map<String, dynamic> json) => ProductDetailModal(
    result: Result.fromJson(json["Result"]),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": result.toJson(),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };


  getProductDetail(String id){
    if(!_loading) {
      _loading=true;
      NetworkUtils.getRequest(endPoint: "" + Constant.GetProductById+id).then((r) {
        _loading=false;
        print("getProductDetail = $r");
        setData(json.decode(r)) ;

      }).catchError((e) {
        _loading=false;
        print("Error caught in getProductDetail $e");
      });
    }
  }

  void setData(decode) {

    result = Result.fromJson(decode["Result"]);
    statusCode =  decode["StatusCode"];
    message= decode["Message"];
    isError = decode["IsError"];


    loaded=true;
    notifyListeners();
  }

}

class Result {
  String id;
  String unitId;
  bool isActive;
  String seoTags;
  bool enableSerialNumber;
  bool enableBatchNumber;
  String brandId;
  String manufacturerId;
  dynamic categoryId;
  int upc;
  String sku;
  int expiryPeriod;
  dynamic expiryPeriodType;
  dynamic barCodeType;
  double alertQuantity;
  dynamic productImage;
  dynamic unit;
  List<dynamic> productExtraFields;
  List<ProductVariant> productVariants;
  dynamic manufacturer;
  List<ProductTag> productTags;
  List<dynamic> productVariantAttributeGroup;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  Result({
    this.id,
    this.unitId,
    this.isActive,
    this.seoTags,
    this.enableSerialNumber,
    this.enableBatchNumber,
    this.brandId,
    this.manufacturerId,
    this.categoryId,
    this.upc,
    this.sku,
    this.expiryPeriod,
    this.expiryPeriodType,
    this.barCodeType,
    this.alertQuantity,
    this.productImage,
    this.unit,
    this.productExtraFields,
    this.productVariants,
    this.manufacturer,
    this.productTags,
    this.productVariantAttributeGroup,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    unitId: json["UnitId"],
    isActive: json["IsActive"],
    seoTags: json["SeoTags"],
    enableSerialNumber: json["EnableSerialNumber"],
    enableBatchNumber: json["EnableBatchNumber"],
    brandId: json["BrandId"],
    manufacturerId: json["ManufacturerId"],
    categoryId: json["CategoryId"],
    upc: json["Upc"],
    sku: json["Sku"],
    expiryPeriod: json["ExpiryPeriod"],
    expiryPeriodType: json["ExpiryPeriodType"],
    barCodeType: json["BarCodeType"],
    alertQuantity: json["AlertQuantity"],
    productImage: json["ProductImage"],
    unit: json["Unit"],
    productExtraFields: List<dynamic>.from(json["ProductExtraFields"].map((x) => x)),
    productVariants: List<ProductVariant>.from(json["ProductVariants"].map((x) => ProductVariant.fromJson(x))),
    manufacturer: json["Manufacturer"],
    productTags: List<ProductTag>.from(json["ProductTags"].map((x) => ProductTag.fromJson(x))),
    productVariantAttributeGroup: List<dynamic>.from(json["ProductVariantAttributeGroup"].map((x) => x)),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UnitId": unitId,
    "IsActive": isActive,
    "SeoTags": seoTags,
    "EnableSerialNumber": enableSerialNumber,
    "EnableBatchNumber": enableBatchNumber,
    "BrandId": brandId,
    "ManufacturerId": manufacturerId,
    "CategoryId": categoryId,
    "Upc": upc,
    "Sku": sku,
    "ExpiryPeriod": expiryPeriod,
    "ExpiryPeriodType": expiryPeriodType,
    "BarCodeType": barCodeType,
    "AlertQuantity": alertQuantity,
    "ProductImage": productImage,
    "Unit": unit,
    "ProductExtraFields": List<dynamic>.from(productExtraFields.map((x) => x)),
    "ProductVariants": List<dynamic>.from(productVariants.map((x) => x.toJson())),
    "Manufacturer": manufacturer,
    "ProductTags": List<dynamic>.from(productTags.map((x) => x.toJson())),
    "ProductVariantAttributeGroup": List<dynamic>.from(productVariantAttributeGroup.map((x) => x)),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class ProductTag {
  String productId;
  String tagId;
  bool showTagImage;
  dynamic tag;
  dynamic product;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductTag({
    this.productId,
    this.tagId,
    this.showTagImage,
    this.tag,
    this.product,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) => ProductTag(
    productId: json["ProductId"],
    tagId: json["TagId"],
    showTagImage: json["ShowTagImage"],
    tag: json["Tag"],
    product: json["Product"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "TagId": tagId,
    "ShowTagImage": showTagImage,
    "Tag": tag,
    "Product": product,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class ProductVariant {
  String id;
  String productId;
  String primaryMediaId;
  bool isDefault;
  bool isActive;
  String status;
  List<dynamic> productVariantMedias;
  List<dynamic> productAttributes;
  List<ProductDetailElement> productDetails;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductVariant({
    this.id,
    this.productId,
    this.primaryMediaId,
    this.isDefault,
    this.isActive,
    this.status,
    this.productVariantMedias,
    this.productAttributes,
    this.productDetails,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: json["Id"],
    productId: json["ProductId"],
    primaryMediaId: json["PrimaryMediaId"],
    isDefault: json["IsDefault"],
    isActive: json["IsActive"],
    status: json["Status"],
    productVariantMedias: List<dynamic>.from(json["ProductVariantMedias"].map((x) => x)),
    productAttributes: List<dynamic>.from(json["ProductAttributes"].map((x) => x)),
    productDetails: List<ProductDetailElement>.from(json["ProductDetails"].map((x) => ProductDetailElement.fromJson(x))),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProductId": productId,
    "PrimaryMediaId": primaryMediaId,
    "IsDefault": isDefault,
    "IsActive": isActive,
    "Status": status,
    "ProductVariantMedias": List<dynamic>.from(productVariantMedias.map((x) => x)),
    "ProductAttributes": List<dynamic>.from(productAttributes.map((x) => x)),
    "ProductDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class ProductDetailElement {
  String productVariantId;
  String language;
  String name;
  String summary;
  String description;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductDetailElement({
    this.productVariantId,
    this.language,
    this.name,
    this.summary,
    this.description,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductDetailElement.fromJson(Map<String, dynamic> json) => ProductDetailElement(
    productVariantId: json["ProductVariantId"],
    language: json["Language"],
    name: json["Name"],
    summary: json["Summary"],
    description: json["Description"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "ProductVariantId": productVariantId,
    "Language": language,
    "Name": name,
    "Summary": summary,
    "Description": description,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}
