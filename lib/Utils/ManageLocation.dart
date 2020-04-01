import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as _location;
import 'package:location_permissions/location_permissions.dart';
import 'package:vegetos_flutter/Utils/config.dart';
import 'package:vegetos_flutter/Utils/google_places_picker.dart';

class ManageLocation{

  static Future<bool> checkEnabledLocationService() async {

    _location.Location location = new _location.Location();

    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> locationPermission() async {

    bool isGranted = false;
    ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();

    if(serviceStatus != ServiceStatus.enabled){
      bool isOpened = await _location.Location().requestService();
      isGranted = false;
    } else {
      PermissionStatus permission = await LocationPermissions().checkPermissionStatus();
      if(permission == PermissionStatus.denied){
        PermissionStatus requestPermission = await LocationPermissions().requestPermissions();
        if(requestPermission == PermissionStatus.denied) {
          Fluttertoast.showToast(msg: 'Please Allow Location Permission for better use');
          isGranted = false;
        } else {
          isGranted = true;
        }
      } else {
        isGranted = true;
      }
    }
    return isGranted;
  }

  Future<dynamic> placeAutoCompleteShow(BuildContext context) async {
    return await PlacesAutocomplete.show(
      context: context,
      apiKey: Platform.isIOS ? Config.kGoogleApiKeyIos : Config.kGoogleApiKeyAndroid,
      hint: "Search for area, location or pincode",
      onError: (e) {
        Fluttertoast.showToast(msg: e != null ? e.errorMessage.toString() : '');
      },
      mode: Mode.overlay, // Mode.fullscreen
      language: "IN",
    );
  }

  Future<Address> findAddressesFromQuery(String address) async{
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    if(addresses != null && addresses.first != null){
      if(addresses.first.postalCode == null && addresses.first.coordinates != null) {
        return findAddressesFromCoordinates(addresses.first.coordinates);
      }
      return addresses.first;
    } else {
      return null;
    }
  }

  Future<Address> findAddressesFromCoordinates(Coordinates coordinates) async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    if(addresses != null && addresses.first != null) {
      return addresses.first;
    }
    return null;
  }

  Future<Address> getCurrentAddress() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(position != null){
      return findAddressesFromCoordinates(new Coordinates(position.latitude,position.longitude));
    } else {
      return null;
    }
  }

}