import 'package:vegetos_flutter/models/search_products.dart';

class Enumaration{

}
class EnumDateFormat extends Enumaration{
    static final String app = "dd-MM-yyyy";
    static final String dateMonth = "dd MMM yyyy";
    static final String appWithTime = "dd-MM-yyyy HH:mm:ss";
    static final String appWithTimeA = "dd-MM-yyyy hh:mm a";
    static final String server = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    static final String serverDate = "yyyy-MM-dd";
    static final String serverWithTime = "yyyy-MM-dd'T'HH:mm:ss";
}

class EnumNamePrefix extends Enumaration{
    static final String namePrefix_Mr = "Mr";
    static final String namePrefix_Mrs = "Mrs";
    static final String namePrefix_Miss = "Miss";

    static String getNamePrefix(int value){
        if(value==0){
            return namePrefix_Mr;
        }else if(value==1){
            return namePrefix_Mrs;
        }else if(value==2){
            return namePrefix_Miss;
        }else{
            return "";
        }
    }
    static int getNamePrefixInt(String value){
        if(value==namePrefix_Mr){
            return 0;
        }else if(value==namePrefix_Mrs){
            return 1;
        }else if(value==namePrefix_Miss){
            return 2;
        }else{
            return -1;
        }
    }
}

final categoryNameValues = EnumValues({
    "Cereals": CategoryName.CEREALS,
    "Fruits": CategoryName.FRUITS,
    "Pulses": CategoryName.PULSES,
    "Vegetables ": CategoryName.VEGETABLES
});

final DeliveryStatusValues = EnumValues({
    "0" : DeliveryStatus.Draft,
    "1" : DeliveryStatus.Pending,
    "2" : DeliveryStatus.Failed,
    "3" : DeliveryStatus.Ordered,
    "4" : DeliveryStatus.Confirmed,
    "5" : DeliveryStatus.Rejected,
    "6" : DeliveryStatus.Cancelled,
    "7" : DeliveryStatus.InTransit,
    "8" : DeliveryStatus.Rejected
});
enum DeliveryStatus {
    Draft,
    Pending,
    Failed,
    Ordered,
    Confirmed,
    Rejected,
    Cancelled,
    InTransit,
    Received,
}

class EnumPaymentMode extends Enumaration{
    static final String Cash = "Cash";
    static final String Card = "Card";
    static final String Online = "Online";
    static final String Bank = "Bank";
    static final String Wallet = "Wallet";
    static final String COD = "COD";

    static String getPaymentModeStr(int mode){
        if(mode==0){
            return EnumPaymentMode.Cash;
        }else if(mode==1){
            return EnumPaymentMode.Card;
        }else if(mode==2){
            return EnumPaymentMode.Online;
        }else if(mode==3){
            return EnumPaymentMode.Bank;
        }else if(mode==4){
            return EnumPaymentMode.Wallet;
        }else if(mode==5){
            return EnumPaymentMode.COD;
        }


    }
}
enum PaymentMode {
    Cash,
    Card,
    Online,
    Bank,
    Wallet,
    COD
}

