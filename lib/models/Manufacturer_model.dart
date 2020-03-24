

class Manufacturer {

  String imageUrl;
  String name;
  String address;
  String phoneNumber;
  String email;

  Manufacturer({this.imageUrl, this.name, this.address, this.phoneNumber, this.email});

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    imageUrl: json["ImageUrl"],
    name: json["Name"],
    address: json["Address"],
    phoneNumber: json["PhoneNumber"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson () => {
    "ImageUrl" : imageUrl,
    "Name" : name,
    "Address" : address,
    "PhoneNumber" : phoneNumber,
    "Email" : email,
  };
}