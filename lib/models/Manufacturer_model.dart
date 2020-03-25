// To parse this JSON data, do
//
//     final getManufacturerById = getManufacturerByIdFromJson(jsonString);

import 'dart:convert';

GetManufacturerById getManufacturerByIdFromJson(String str) => GetManufacturerById.fromJson(json.decode(str));

String getManufacturerByIdToJson(GetManufacturerById data) => json.encode(data.toJson());

class GetManufacturerById {
  Result result;
  int statusCode;
  String message;
  bool isError;

  GetManufacturerById({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory GetManufacturerById.fromJson(Map<String, dynamic> json) => GetManufacturerById(
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
}

class Result {
  String id;
  String name;
  String createdBy;
  DateTime createdOn;

  Result({
    this.id,
    this.name,
    this.createdBy,
    this.createdOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    name: json["Name"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };
}
