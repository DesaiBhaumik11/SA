// To parse this JSON data, do
//
//     final offerZone = offerZoneFromJson(jsonString);

import 'dart:convert';

OfferZone offerZoneFromJson(String str) => OfferZone.fromJson(json.decode(str));

String offerZoneToJson(OfferZone data) => json.encode(data.toJson());

class OfferZone {
  List<Result> result;
  String version;
  int statusCode;
  String message;
  bool isError;

  OfferZone({
    this.result,
    this.version,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory OfferZone.fromJson(Map<String, dynamic> json) => OfferZone(
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
}

class Result {
  String id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool allowMultipleTime;
  String status;
  int displayOrder;
  String termsAndCondition;
  String bannerMediaId;
  String bannerWebUrl;
  String bannerAndroidUrl;
  String bannerIosUrl;
  String triggerType;
  String triggerData;
  int maxAmount;
  String coponCode;
  int percentageDiscount;
  String outcomeType;
  String createdBy;
  DateTime createdOn;
  int numberOfTimes;

  Result({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.allowMultipleTime,
    this.status,
    this.displayOrder,
    this.termsAndCondition,
    this.bannerMediaId,
    this.bannerWebUrl,
    this.bannerAndroidUrl,
    this.bannerIosUrl,
    this.triggerType,
    this.triggerData,
    this.maxAmount,
    this.coponCode,
    this.percentageDiscount,
    this.outcomeType,
    this.createdBy,
    this.createdOn,
    this.numberOfTimes,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    title: json["Title"],
    description: json["Description"],
    startDate: DateTime.parse(json["StartDate"]),
    endDate: DateTime.parse(json["EndDate"]),
    allowMultipleTime: json["AllowMultipleTime"],
    status: json["Status"],
    displayOrder: json["DisplayOrder"],
    termsAndCondition: json["TermsAndCondition"],
    bannerMediaId: json["BannerMediaId"],
    bannerWebUrl: json["BannerWebUrl"],
    bannerAndroidUrl: json["BannerAndroidUrl"],
    bannerIosUrl: json["BannerIosUrl"],
    triggerType: json["TriggerType"],
    triggerData: json["TriggerData"],
    maxAmount: json["MaxAmount"],
    coponCode: json["CoponCode"],
    percentageDiscount: json["PercentageDiscount"],
    outcomeType: json["OutcomeType"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    numberOfTimes: json["NumberOfTimes"] == null ? null : json["NumberOfTimes"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Description": description,
    "StartDate": startDate.toIso8601String(),
    "EndDate": endDate.toIso8601String(),
    "AllowMultipleTime": allowMultipleTime,
    "Status": status,
    "DisplayOrder": displayOrder,
    "TermsAndCondition": termsAndCondition,
    "BannerMediaId": bannerMediaId,
    "BannerWebUrl": bannerWebUrl,
    "BannerAndroidUrl": bannerAndroidUrl,
    "BannerIosUrl": bannerIosUrl,
    "TriggerType": triggerType,
    "TriggerData": triggerData,
    "MaxAmount": maxAmount,
    "CoponCode": coponCode,
    "PercentageDiscount": percentageDiscount,
    "OutcomeType": outcomeType,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "NumberOfTimes": numberOfTimes == null ? null : numberOfTimes,
  };
}
