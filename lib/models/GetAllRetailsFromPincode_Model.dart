// To parse this JSON data, do
//
//     final getAllRetailsForPincode = getAllRetailsForPincodeFromJson(jsonString);

import 'dart:convert';

GetAllRetailsForPinCode getAllRetailsForPinCodeFromJson(String str) => GetAllRetailsForPinCode.fromJson(json.decode(str));

String getAllRetailsForPinCodeToJson(GetAllRetailsForPinCode data) => json.encode(data.toJson());

class GetAllRetailsForPinCode {
  String id;
  String businessId;
  String locationType;
  String name;
  String code;
  String addressId;
  String isdCode;
  String parentLocationId;
  String mobile;
  List<int> pinCodes;
  String status;
  RetailsAddress retailsAddress;
  String createdBy;
  DateTime createdOn;

  GetAllRetailsForPinCode({
    this.id,
    this.businessId,
    this.locationType,
    this.name,
    this.code,
    this.addressId,
    this.isdCode,
    this.parentLocationId,
    this.mobile,
    this.pinCodes,
    this.status,
    this.retailsAddress,
    this.createdBy,
    this.createdOn,
  });

  factory GetAllRetailsForPinCode.fromJson(Map<String, dynamic> json) => GetAllRetailsForPinCode(
    id: json["Id"],
    businessId: json["BusinessId"],
    locationType: json["LocationType"],
    name: json["Name"],
    code: json["Code"],
    addressId: json["AddressId"],
    isdCode: json["IsdCode"],
    parentLocationId: json["ParentLocationId"],
    mobile: json["Mobile"],
    pinCodes: List<int>.from(json["Pincodes"].map((x) => x)),
    status: json["Status"],
    retailsAddress: RetailsAddress.fromJson(json["Address"]),
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "BusinessId": businessId,
    "LocationType": locationType,
    "Name": name,
    "Code": code,
    "AddressId": addressId,
    "IsdCode": isdCode,
    "ParentLocationId": parentLocationId,
    "Mobile": mobile,
    "Pincodes": List<dynamic>.from(pinCodes.map((x) => x)),
    "Status": status,
    "Address": retailsAddress.toJson(),
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
  };

  static List<GetAllRetailsForPinCode> parseList(listData) {
    var list = listData as List;
    List<GetAllRetailsForPinCode> jobList =
    list.map((data) => GetAllRetailsForPinCode.fromJson(data)).toList();
    return jobList;
  }
}

class RetailsAddress {
  String id;
  String name;
  String addressLine1;
  String addressLine2;
  String city;
  String country;
  String state;
  String pin;
  bool isDefault;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  RetailsAddress({
    this.id,
    this.name,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.state,
    this.pin,
    this.isDefault,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory RetailsAddress.fromJson(Map<String, dynamic> json) => RetailsAddress(
    id: json["Id"],
    name: json["Name"],
    addressLine1: json["AddressLine1"],
    addressLine2: json["AddressLine2"],
    city: json["City"],
    country: json["Country"],
    state: json["State"],
    pin: json["Pin"],
    isDefault: json["IsDefault"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "AddressLine1": addressLine1,
    "AddressLine2": addressLine2,
    "City": city,
    "Country": country,
    "State": state,
    "Pin": pin,
    "IsDefault": isDefault,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn.toIso8601String(),
  };
}
