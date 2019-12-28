// To parse this JSON data, do
//
//     final addressModal = addressModalFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetos_flutter/Utils/const_endpoint.dart';
import 'package:vegetos_flutter/Utils/newtwork_util.dart';

AddressModal addressModalFromJson(String str) => AddressModal.fromJson(json.decode(str));

String addressModalToJson(AddressModal data) => json.encode(data.toJson());

class AddressModal extends ChangeNotifier{
  List<Result> result=List();
  int statusCode;
  String message;
  String defaultAddress ="No Location Found";
  bool isError;
  bool loaded = false ;
  bool is_loading = false ;


  AddressModal({
    this.result,
    this.statusCode,
    this.message,
    this.isError,
  });

  factory AddressModal.fromJson(Map<String, dynamic> json) => AddressModal(
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    statusCode: json["StatusCode"],
    message: json["Message"],
    isError: json["IsError"],
  );

  Map<String, dynamic> toJson() => {
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "StatusCode": statusCode,
    "Message": message,
    "IsError": isError,
  };


  getMyAddresses(){
    if(!is_loading){
      is_loading = true ;
      NetworkUtils.getRequest(endPoint: Constant.getMyAddresses).then((response){
        is_loading = false  ;
        print("getMyAddresses = $response");

       {
          setData(json.decode(response)) ;
        }
      }).catchError((e){
        loaded =true ;
        setData({});
        //notifyListeners();

      });
    }
  }

   setDefaultAddress(String id , ){
     defaultAddress = "" ;
    NetworkUtils.getRequest(endPoint: "${Constant.SetDefaultAddress}${id}").then((res){
      getMyAddresses() ;

    });
  }

  void setData(decode) {
    result = List() ;
    if(decode["Result"]!=null){
      result.addAll(List<Result>.from(decode["Result"].map((x) => Result.fromJson(x)))) ;

      for(int i=0 ; i<result.length ; i++){
       if(result[i].isDefault){
         defaultAddress = result[i].name + " , " + result[i].city ;
       }
      }


    }

//    statusCode= decode["StatusCode"] ;
//    message= decode["Message"];
//    isError= decode["IsError"] ;
    loaded = true ;
    notifyListeners() ;
  }

  addAddress(Result result,{callback}){

      Map<String,dynamic> map={
      "Name":          result.name,
      "AddressLine1":  result.addressLine1,
      "AddressLine2":  result.addressLine2,
      "City":          result.city,
      "Country":       result.country,
      "State":         result.state,
      "Pin":           result.pin,
      "Latitude":      result.latitude,
      "Longitude":     result.longitude,
      "IsDefault":     result.isDefault
    };
    NetworkUtils.postRequest(endpoint:Constant.AddAddress,body: json.encode(map)).then((r){
      print("addAddress response = $r");

      getMyAddresses() ;

//      var root=json.decode(r);
//     {
//        this.result.add(Result.fromJson((root['Result'])));
//        if(callback!=null){
//          callback();
//        }
//        notifyListeners();
//      }
    }).catchError((e){
      print("Error Catch in addAddress  ${e}") ;
    });
  }

  updateAddress(Result result,{callback}) {
    Map<String,dynamic> map={
      "Id":            result.id,
      "Name":          result.name,
      "ContactId":     result.contactId,
      "AddressLine1":  result.addressLine1,
      "AddressLine2":  result.addressLine2,
      "City":          result.city,
      "Country":       result.country,
      "State":         result.state,
      "Pin":           result.pin,
      "Latitude":      result.latitude,
      "Longitude":     result.longitude,
      "IsDefault":     result.isDefault
    };
    NetworkUtils.putRequest(endpoint:Constant.UpdateAddress,body: json.encode(map)).then((r){
      print("Update request response $r");
      var root=json.decode(r);
      if(root['IsError']){
        Fluttertoast.showToast(msg: "error in update");
      }else {
        getMyAddresses();
        if(callback!=null){
          callback();
        }
        notifyListeners();
      }
    });
  }

  void deleteAddress(id, {callback}) {
    NetworkUtils.deleteRequest(endPoint: "${Constant.DeleteAddress}$id").then((r){

        result.removeWhere((e)=>e.id==id);

      if(callback!=null){
        callback();
      }
      notifyListeners();
    });
  }

}

class Result {
  String id;
  String name;
  String contactId;
  String addressLine1;
  String addressLine2;
  String city;
  String country;
  String state;
  String pin;
  double latitude;
  double longitude;
  bool isDefault;
  String updatedBy;
  String createdBy;
  DateTime createdOn;
  DateTime updatedOn;

  Result({
    this.id,
    this.name,
    this.contactId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.state,
    this.pin,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.updatedBy,
    this.createdBy,
    this.createdOn,
    this.updatedOn,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    name: json["Name"],
    contactId: json["ContactId"],
    addressLine1: json["AddressLine1"],
    addressLine2: json["AddressLine2"],
    city: json["City"],
    country: json["Country"],
    state: json["State"],
    pin: json["Pin"],
    latitude: json["Latitude"] == null ? null : json["Latitude"],
    longitude: json["Longitude"] == null ? null : json["Longitude"],
    isDefault: json["IsDefault"],
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "ContactId": contactId,
    "AddressLine1": addressLine1,
    "AddressLine2": addressLine2,
    "City": city,
    "Country": country,
    "State": state,
    "Pin": pin,
    "Latitude": latitude == null ? null : latitude,
    "Longitude": longitude == null ? null : longitude,
    "IsDefault": isDefault,
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
  };
}
