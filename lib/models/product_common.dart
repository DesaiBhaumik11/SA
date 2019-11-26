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
  int expiryPeriodType;
  dynamic barCodeType;
  double alertQuantity;
  dynamic productImage;
  dynamic unit;
  List<dynamic> productExtraFields;
  List<dynamic> productVariants;
  List<dynamic> productTags;
  List<dynamic> productVariantAttributeGroup;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;
  String test;

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
    this.productTags,
    this.productVariantAttributeGroup,
    this.updatedBy,
    this.createdBy,
    this.test,
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
    test: json['test'],
    expiryPeriod: json["ExpiryPeriod"],
    expiryPeriodType: json["ExpiryPeriodType"],
    barCodeType: json["BarCodeType"],
    alertQuantity: json["AlertQuantity"],
    productImage: json["ProductImage"],
    unit: json["Unit"],
    productExtraFields: List<dynamic>.from(json["ProductExtraFields"].map((x) => x)),
    productVariants: List<dynamic>.from(json["ProductVariants"].map((x) => x)),
    productTags: List<dynamic>.from(json["ProductTags"].map((x) => x)),
    productVariantAttributeGroup: List<dynamic>.from(json["ProductVariantAttributeGroup"].map((x) => x)),
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
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
    "ProductExtraFields": List<dynamic>.from(productExtraFields.map((x) => x)),
    "ProductVariants": List<dynamic>.from(productVariants.map((x) => x)),
    "ProductTags": List<dynamic>.from(productTags.map((x) => x)),
    "ProductVariantAttributeGroup": List<dynamic>.from(productVariantAttributeGroup.map((x) => x)),
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
  };
}