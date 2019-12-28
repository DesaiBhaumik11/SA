// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel extends ChangeNotifier {
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
      print("searchProducts REsponse = $r");
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
  CategoryName categoryName;
  String categoryParentId;
  String categoryMediaId;
  String manufacturerName;
  String brandName;
  List<Unit> units;
  List<Tag> tags;
  List<ProductExtraField> productExtraFields;
  List<ProductVariantAttributeGroup> productVariantAttributeGroups;
  List<ProductAttribute> productAttributes;
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
    categoryName: categoryNameValues.map[json["CategoryName"]],
    categoryParentId: json["CategoryParentId"],
    categoryMediaId: json["CategoryMediaId"],
    manufacturerName: json["ManufacturerName"],
    brandName: json["BrandName"],
    units: List<Unit>.from(json["Units"].map((x) => Unit.fromJson(x))),
    tags: json["Tags"] == null ? null : List<Tag>.from(json["Tags"].map((x) => Tag.fromJson(x))),
    productExtraFields: json["ProductExtraFields"] == null ? null : List<ProductExtraField>.from(json["ProductExtraFields"].map((x) => ProductExtraField.fromJson(x))),
    productVariantAttributeGroups: json["ProductVariantAttributeGroups"] == null ? null : List<ProductVariantAttributeGroup>.from(json["ProductVariantAttributeGroups"].map((x) => ProductVariantAttributeGroup.fromJson(x))),
    productAttributes: json["ProductAttributes"] == null ? null : List<ProductAttribute>.from(json["ProductAttributes"].map((x) => ProductAttribute.fromJson(x))),
    productDetails: json["ProductDetails"] == null ? null : List<ProductDetail>.from(json["ProductDetails"].map((x) => ProductDetail.fromJson(x))),
    productVariantMedia: json["ProductVariantMedia"] == null ? null : List<String>.from(json["ProductVariantMedia"].map((x) => x)),
    productTax: ProductTax.fromJson(json["ProductTax"]),
    productPrice: json["ProductPrice"] == null ? null : ProductPrice.fromJson(json["ProductPrice"]),
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
    "CategoryName": categoryNameValues.reverse[categoryName],
    "CategoryParentId": categoryParentId,
    "CategoryMediaId": categoryMediaId,
    "ManufacturerName": manufacturerName,
    "BrandName": brandName,
    "Units": List<dynamic>.from(units.map((x) => x.toJson())),
    "Tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x.toJson())),
    "ProductExtraFields": productExtraFields == null ? null : List<dynamic>.from(productExtraFields.map((x) => x.toJson())),
    "ProductVariantAttributeGroups": productVariantAttributeGroups == null ? null : List<dynamic>.from(productVariantAttributeGroups.map((x) => x.toJson())),
    "ProductAttributes": productAttributes == null ? null : List<dynamic>.from(productAttributes.map((x) => x.toJson())),
    "ProductDetails": productDetails == null ? null : List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "ProductVariantMedia": productVariantMedia == null ? null : List<dynamic>.from(productVariantMedia.map((x) => x)),
    "ProductTax": productTax.toJson(),
    "ProductPrice": productPrice == null ? null : productPrice.toJson(),
  };
}

enum CategoryName { FRUITS, VEGETABLES, CEREALS, PULSES }

final categoryNameValues = EnumValues({
  "Cereals": CategoryName.CEREALS,
  "Fruits": CategoryName.FRUITS,
  "Pulses": CategoryName.PULSES,
  "Vegetables ": CategoryName.VEGETABLES
});

class ProductAttribute {
  String mediaId;
  String hexColor;
  int displayOrder;
  String language;
  String value;

  ProductAttribute({
    this.mediaId,
    this.hexColor,
    this.displayOrder,
    this.language,
    this.value,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    mediaId: json["MediaId"],
    hexColor: json["HexColor"],
    displayOrder: json["DisplayOrder"],
    language: json["Language"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "MediaId": mediaId,
    "HexColor": hexColor,
    "DisplayOrder": displayOrder,
    "Language": language,
    "Value": value,
  };
}

class ProductDetail {
  Language language;
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
    language: languageValues.map[json["Language"]],
    name: json["Name"],
    summary: json["Summary"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Language": languageValues.reverse[language],
    "Name": name,
    "Summary": summary,
    "Description": description,
  };
}

enum Language { EN_US, HI_IN }

final languageValues = EnumValues({
  "En-US": Language.EN_US,
  "Hi-IN": Language.HI_IN
});

class ProductExtraField {
  Language language;
  Title title;
  Value value;

  ProductExtraField({
    this.language,
    this.title,
    this.value,
  });

  factory ProductExtraField.fromJson(Map<String, dynamic> json) => ProductExtraField(
    language: languageValues.map[json["Language"]],
    title: titleValues.map[json["Title"]],
    value: valueValues.map[json["Value"]],
  );

  Map<String, dynamic> toJson() => {
    "Language": languageValues.reverse[language],
    "Title": titleValues.reverse[title],
    "Value": valueValues.reverse[value],
  };
}

enum Title { DISCLAIMER, SHELF_LIFE, TERMS_AND_CONDITION }

final titleValues = EnumValues({
  "Disclaimer": Title.DISCLAIMER,
  "Shelf Life": Title.SHELF_LIFE,
  "Terms and Condition": Title.TERMS_AND_CONDITION
});

enum Value { DISCLAIMER_DETAIL, SHELF_LIFE_DETAIL, TERMS_AND_CONDITION_DETAILS }

final valueValues = EnumValues({
  "Disclaimer Detail": Value.DISCLAIMER_DETAIL,
  "Shelf Life Detail": Value.SHELF_LIFE_DETAIL,
  "Terms and Condition Details": Value.TERMS_AND_CONDITION_DETAILS
});

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
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
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
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
  };
}

class Tax {
  String id;
  TaxName name;
  double rate;
  dynamic parentId;
  dynamic baseTax;
  List<dynamic> taxes;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

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
    name: taxNameValues.map[json["Name"]],
    rate: json["Rate"],
    parentId: json["ParentId"],
    baseTax: json["BaseTax"],
    taxes: List<dynamic>.from(json["Taxes"].map((x) => x)),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": taxNameValues.reverse[name],
    "Rate": rate,
    "ParentId": parentId,
    "BaseTax": baseTax,
    "Taxes": List<dynamic>.from(taxes.map((x) => x)),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
  };
}

enum TaxName { WSGST, GST }

final taxNameValues = EnumValues({
  "GST": TaxName.GST,
  "WSGST": TaxName.WSGST
});

class ProductVariantAttributeGroup {
  String groupName;
  int displayOrder;

  ProductVariantAttributeGroup({
    this.groupName,
    this.displayOrder,
  });

  factory ProductVariantAttributeGroup.fromJson(Map<String, dynamic> json) => ProductVariantAttributeGroup(
    groupName: json["GroupName"],
    displayOrder: json["DisplayOrder"],
  );

  Map<String, dynamic> toJson() => {
    "GroupName": groupName,
    "DisplayOrder": displayOrder,
  };
}

class Tag {
  String tagId;
  bool showTagImage;
  TagTitle tagTitle;
  TagSeoNames tagSeoNames;
  String tagMediaId;
  bool allowDetail;

  Tag({
    this.tagId,
    this.showTagImage,
    this.tagTitle,
    this.tagSeoNames,
    this.tagMediaId,
    this.allowDetail,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    tagId: json["TagId"],
    showTagImage: json["ShowTagImage"],
    tagTitle: tagTitleValues.map[json["TagTitle"]],
    tagSeoNames: tagSeoNamesValues.map[json["TagSeoNames"]],
    tagMediaId: json["TagMediaId"],
    allowDetail: json["AllowDetail"],
  );

  Map<String, dynamic> toJson() => {
    "TagId": tagId,
    "ShowTagImage": showTagImage,
    "TagTitle": tagTitleValues.reverse[tagTitle],
    "TagSeoNames": tagSeoNamesValues.reverse[tagSeoNames],
    "TagMediaId": tagMediaId,
    "AllowDetail": allowDetail,
  };
}

enum TagSeoNames { DHRUV, NON_VEGETERIAN }

final tagSeoNamesValues = EnumValues({
  "Dhruv": TagSeoNames.DHRUV,
  "Non vegeterian": TagSeoNames.NON_VEGETERIAN
});

enum TagTitle { DHRUV, NON_VEG }

final tagTitleValues = EnumValues({
  "Dhruv": TagTitle.DHRUV,
  "Non-Veg": TagTitle.NON_VEG
});

class Unit {
  String unitId;
  String baseUnitId;
  double baseUnitMultiplier;
  int decimalPlaces;
  Language language;
  Code code;
  UnitName name;

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
    language: languageValues.map[json["Language"]],
    code: codeValues.map[json["Code"]],
    name: unitNameValues.map[json["Name"]],
  );

  Map<String, dynamic> toJson() => {
    "UnitId": unitId,
    "BaseUnitId": baseUnitId,
    "BaseUnitMultiplier": baseUnitMultiplier,
    "DecimalPlaces": decimalPlaces,
    "Language": languageValues.reverse[language],
    "Code": codeValues.reverse[code],
    "Name": unitNameValues.reverse[name],
  };
}

enum Code { KG, DZ, LITRE, EMPTY }

final codeValues = EnumValues({
  "Dz": Code.DZ,
  "लीटर": Code.EMPTY,
  "KG": Code.KG,
  "Litre": Code.LITRE
});

enum UnitName { KILOGRAM, DOZEN, LITRE, EMPTY }

final unitNameValues = EnumValues({
  "Dozen": UnitName.DOZEN,
  "लीटर": UnitName.EMPTY,
  "Kilogram": UnitName.KILOGRAM,
  "Litre": UnitName.LITRE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
