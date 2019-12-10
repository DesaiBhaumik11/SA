// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';


class Result {
  String id;
  String unitId;
  bool isActive;
  String seoTags;
  bool enableSerialNumber;
  bool enableBatchNumber;
  String brandId;
  String manufacturerId;
  String categoryId;
  int upc;
  String sku;
  int expiryPeriod;
  dynamic expiryPeriodType;
  dynamic barCodeType;
  int alertQuantity;
  dynamic productImage;
  dynamic unit;
  List<ProductExtraField> productExtraFields;
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

  factory Result.fromMap(Map<String, dynamic> json) => Result(
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
    productExtraFields: List<ProductExtraField>.from(json["ProductExtraFields"].map((x) => ProductExtraField.fromJson(x))),
    productVariants: List<ProductVariant>.from(json["ProductVariants"].map((x) => ProductVariant.fromJson(x))),
    manufacturer: json["Manufacturer"],
    productTags: List<ProductTag>.from(json["ProductTags"].map((x) => ProductTag.fromJson(x))),
    productVariantAttributeGroup: List<dynamic>.from(json["ProductVariantAttributeGroup"].map((x) => x)),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toMap() => {
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
    "ProductExtraFields": List<dynamic>.from(productExtraFields.map((x) => x.toJson())),
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

  factory ProductExtraField.fromJson(Map<String, dynamic> json) => ProductExtraField(
    productId: json["ProductId"],
    language: json["Language"],
    title: json["Title"],
    value: json["Value"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "Language": language,
    "Title": title,
    "Value": value,
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
  List<ProductVariantMedia> productVariantMedias;
  List<dynamic> productAttributes;
  List<ProductDetail> productDetails;
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
    productVariantMedias: List<ProductVariantMedia>.from(json["ProductVariantMedias"].map((x) => ProductVariantMedia.fromJson(x))),
    productAttributes: List<dynamic>.from(json["ProductAttributes"].map((x) => x)),
    productDetails: List<ProductDetail>.from(json["ProductDetails"].map((x) => ProductDetail.fromJson(x))),
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
    "ProductVariantMedias": List<dynamic>.from(productVariantMedias.map((x) => x.toJson())),
    "ProductAttributes": List<dynamic>.from(productAttributes.map((x) => x)),
    "ProductDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}

class ProductDetail {
  String productVariantId;
  String language;
  String name;
  String summary;
  String description;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductDetail({
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

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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

class ProductVariantMedia {
  String productVariantId;
  String mediaId;
  dynamic productVariant;
  dynamic productFormFiles;
  dynamic updatedBy;
  String createdBy;
  DateTime createdOn;
  dynamic updatedOn;

  ProductVariantMedia({
    this.productVariantId,
    this.mediaId,
    this.productVariant,
    this.productFormFiles,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory ProductVariantMedia.fromJson(Map<String, dynamic> json) => ProductVariantMedia(
    productVariantId: json["ProductVariantId"],
    mediaId: json["MediaId"],
    productVariant: json["ProductVariant"],
    productFormFiles: json["ProductFormFiles"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "ProductVariantId": productVariantId,
    "MediaId": mediaId,
    "ProductVariant": productVariant,
    "ProductFormFiles": productFormFiles,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn,
  };
}
