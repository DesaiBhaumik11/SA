
import 'package:vegetos_flutter/models/LocationPincodeMappingModel.dart';

//created by Prashant on 08-01-2020
class SetLocationResponseModel
{
  String Id;

  String BusinessId;

  int LocationType;

  String Name;

  String Code;

  String AddressId;

  String IsdCode;

  String Mobile;

  LocationPincodeMappingModel LocationPincodeMapping;

  String UpdatedBy;

  String CreatedBy;

  String CreatedOn;

  SetLocationResponseModel({
    this.Id,
    this.BusinessId,
    this.LocationType,
    this.Name,
    this.Code,
    this.AddressId,
    this.IsdCode,
    this.Mobile,
    this.LocationPincodeMapping,
    this.UpdatedBy,
    this.CreatedBy,
    this.CreatedOn,
  });

  factory SetLocationResponseModel.fromJson(Map<String, dynamic> parsedData) {
    return SetLocationResponseModel(
      Id: parsedData['Id'],
      BusinessId: parsedData['BusinessId'],
      LocationType: parsedData['LocationType'],
      Name: parsedData['Name'],
      Code: parsedData['Code'],
      AddressId: parsedData['AddressId'],
      IsdCode: parsedData['IsdCode'],
      Mobile: parsedData['Mobile'],
      LocationPincodeMapping: parsedData['LocationPincodeMapping'] != null ? LocationPincodeMappingModel.fromJson(parsedData['LocationPincodeMapping']) : null,
      UpdatedBy: parsedData['UpdatedBy'],
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn']
    );
  }
}