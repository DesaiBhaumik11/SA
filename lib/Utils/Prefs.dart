import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static final String DeliveryAddress="DeliveryAddress";
  static final String ImageURL="ImageURL";
  static final String DeliveryAddressId="DeliveryAddressId";
  static final String JWT_TOKEN="JWT_TOKEN";
  static final String AUTH_TOKEN="AUTH_TOKEN";
  static final String phone="phone";


  static Future<bool> setLoginPrefs(String phone,String AUTH_TOKEN) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString(Prefs.AUTH_TOKEN,AUTH_TOKEN) ;
    prefs.setString(Prefs.phone, phone);
    prefs.setBool("login",true) ;
    return true;
  }


  void getMyDefaultAddressByPrefs(String deliveryAddress){
    SharedPreferences.getInstance().then((prefs){
    });
  }

  static Future<bool> setDeliveryAddress(String address,String addressId) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString(Prefs.DeliveryAddress, address);
    prefs.setString(Prefs.DeliveryAddressId,addressId);
    return true;
  }

  static Future<String> getDeliveryAddress() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return preferences.getString(Prefs.DeliveryAddress);
  }

  static Future<String> getDeliveryAddressId() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    return preferences.getString(Prefs.DeliveryAddressId);
  }

}