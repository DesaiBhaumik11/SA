
//created by Prashant on 08-01-2020
class LocationPincodeMappingModel
{
  String BusinessLocationId;

  Object Pincodes;

  String UpdatedBy;

  String CreatedBy;

  String CreatedOn;

  LocationPincodeMappingModel({
    this.BusinessLocationId,
    this.Pincodes,
    this.UpdatedBy,
    this.CreatedBy,
    this.CreatedOn,
  });

  factory LocationPincodeMappingModel.fromJson(Map<String, dynamic> parsedData) {
    return LocationPincodeMappingModel(
      BusinessLocationId: parsedData['BusinessLocationId'],
      Pincodes: parsedData['Pincodes'],
      UpdatedBy: parsedData['UpdatedBy'],
      CreatedBy: parsedData['CreatedBy'],
      CreatedOn: parsedData['CreatedOn'],
    );
  }
}

