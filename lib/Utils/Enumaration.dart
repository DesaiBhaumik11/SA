import 'package:enum_to_string/enum_to_string.dart';
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

enum OrderStatus {
    Draft,
    Failed,
    Ordered,
    Confirmed,
    Rejected,
    CancellationRequested,
    Cancelled,
    Completed
}
class EnumOrderStatus extends Enumaration{
    static final String Draft = "Draft";
    static final String Failed = "Failed";
    static final String Ordered = "Ordered";
    static final String Confirmed = "Confirmed";
    static final String Rejected = "Rejected";
    static final String CancellationRequested = "CancellationRequested";
    static final String Cancelled = "Cancelled";
    static final String Completed = "Completed";

    static String getString(OrderStatus orderStatus) {
        return EnumToString.parse(orderStatus);
    }

}
enum ShippingStatus
{
    Pending,
    OutForDelivery,
    DeliveryAttemptFailed,
    Delivered,
    Refunded
}
class EnumShippingStatus extends Enumaration{
    static final String Pending = "Pending";
    static final String OutForDelivery = "OutForDelivery";
    static final String DeliveryAttemptFailed = "DeliveryAttemptFailed";
    static final String Delivered = "Delivered";
    static final String Refunded = "Refunded";

    static String getString(ShippingStatus shippingStatus) {
        return EnumToString.parse(shippingStatus);
    }
}
enum PaymentStatus
{
    Due,
    Failed,
    Partial,
    Paid,
}
class EnumPaymentStatus extends Enumaration{
    static final String Due = "Due";
    static final String Failed = "Failed";
    static final String Partial = "Partial";
    static final String Paid = "Paid";
    static String getString(PaymentStatus paymentStatus) {
        return EnumToString.parse(paymentStatus);
    }
}
enum ShippingMode
{
    HomeDelivery,
    PickupFromStore
}

enum PaymentMode {
    Cash,
    Card,
    Online,
    Bank,
    Wallet,
    COD
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


