
class AddressModel
{
  String id;
  String namePrefix;
  String name;
  String contactId;
  String addressLine1;
  String addressLine2;
  String city;
  String country;
  String state;
  String pin;
  String title;
  double latitude;
  double longitude;
  bool isDefault;
  String updatedBy;
  String createdBy;
  String createdOn;
  String updatedOn;
  bool isLoaded=false;

  AddressModel({
    this.id,
    this.namePrefix,
    this.name,
    this.contactId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.state,
    this.pin,
    this.title,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
    this.isLoaded,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["Id"],
    namePrefix: json["NamePrefix"],
    name: json["Name"],
    contactId: json["ContactId"],
    addressLine1: json["AddressLine1"],
    addressLine2: json["AddressLine2"],
    city: json["City"],
    country: json["Country"],
    state: json["State"],
    pin: json["Pin"],
    title: json["Title"],
    latitude: json["Latitude"] == null ? null : json["Latitude"],
    longitude: json["Longitude"] == null ? null : json["Longitude"],
    isDefault: json["IsDefault"],
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"],
    updatedOn: json["UpdatedOn"] == null ? null : json["UpdatedOn"],
    isLoaded: true,
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "NamePrefix" : namePrefix,
    "Name": name,
    "ContactId": contactId,
    "AddressLine1": addressLine1,
    "AddressLine2": addressLine2,
    "City": city,
    "Country": country,
    "State": state,
    "Pin": pin,
    "Title": title,
    "Latitude": latitude == null ? null : latitude,
    "Longitude": longitude == null ? null : longitude,
    "IsDefault": isDefault,
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "UpdatedOn": updatedOn == null ? null : updatedOn,
  };
}