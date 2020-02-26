import 'package:vegetos_flutter/UI/custom_stepper.dart';
import 'package:vegetos_flutter/Utils/Enumaration.dart';
import 'package:vegetos_flutter/UI/custom_stepper.dart' as s;

class StatusManagement{
  String status;
  StepState state;
  bool isActive;

  StatusManagement({this.status,this.state,this.isActive});

  static List<StatusManagement> getStatusMangement(String status, String shippingStatus,String paymentStatus) {

    List<StatusManagement> statusManagements=new List();

    if(paymentStatus == EnumPaymentStatus.getString(PaymentStatus.Failed)){
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Failed\n",state: s.StepState.error,isActive: false));
      return statusManagements;
    }

    if (status == EnumOrderStatus.getString(OrderStatus.Ordered)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Confirmed\n",state: s.StepState.indexed,isActive: false));
      statusManagements.add(new StatusManagement(status: "OutForDelivery\n",state: s.StepState.indexed,isActive: false));
      statusManagements.add(new StatusManagement(status: "Delivered\n",state: s.StepState.indexed,isActive: false));

    } else if (status == EnumOrderStatus.getString(OrderStatus.Confirmed) || status == EnumOrderStatus.getString(OrderStatus.Completed)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Confirmed\n",state: s.StepState.complete,isActive: true));
      if (shippingStatus ==
          EnumShippingStatus.getString(ShippingStatus.DeliveryAttemptFailed)) {
        statusManagements.add(new StatusManagement(status: "Delivery \nAttempt Failed",state: s.StepState.complete,isActive: true));
        statusManagements.add(new StatusManagement(status: "Delivered\n",state: s.StepState.indexed,isActive: false));
      } else {
        if(shippingStatus == EnumShippingStatus.getString(ShippingStatus.Delivered) || status == EnumOrderStatus.getString(OrderStatus.Completed)) {
          statusManagements.add(new StatusManagement(status: "OutForDelivery\n", state: s.StepState.complete, isActive: true));
          statusManagements.add(new StatusManagement(status: "Delivered\n",state: s.StepState.complete,isActive: true));
        }else if(shippingStatus == EnumShippingStatus.getString(ShippingStatus.OutForDelivery)){
          statusManagements.add(new StatusManagement(status: "OutForDelivery\n", state: s.StepState.complete, isActive: true));
          statusManagements.add(new StatusManagement(status: "Delivered\n",state: s.StepState.indexed,isActive: false));
        }else{
          statusManagements.add(new StatusManagement(status: "OutForDelivery\n", state: s.StepState.indexed, isActive: false));
          statusManagements.add(new StatusManagement(status: "Delivered\n",state: s.StepState.indexed,isActive: false));
        }
      }
    } else if (status == EnumOrderStatus.getString(OrderStatus.Rejected)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Rejected\n",state: s.StepState.complete,isActive: true));
      statusManagements.add(new StatusManagement(status: "Refunded\n",state: s.StepState.indexed,isActive: false));
//      statusManagements.add(new StatusManagement(status: "OutForDelivery",state: s.StepState.indexed,isActive: false));
//      statusManagements.add(new StatusManagement(status: "Delivered",state: s.StepState.indexed,isActive: false));
    } else if (status == EnumOrderStatus.getString(OrderStatus.CancellationRequested)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Confirmed\n",state: s.StepState.complete,isActive: true));
      statusManagements.add(new StatusManagement(status: "Cancellation \nRequested",state: s.StepState.complete,isActive: true));
      statusManagements.add(new StatusManagement(status: "Cancelled\n",state: s.StepState.indexed,isActive: false));
    }else if (status == EnumOrderStatus.getString(OrderStatus.Cancelled)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Confirmed\n",state: s.StepState.complete,isActive: true));
      statusManagements.add(new StatusManagement(status: "Cancelled\n",state: s.StepState.complete,isActive: true));
      statusManagements.add(new StatusManagement(status: "Refunded\n",state: s.StepState.indexed,isActive: false));
    }
    else if (shippingStatus == EnumShippingStatus.getString(ShippingStatus.Refunded)) {
      statusManagements.add(new StatusManagement(status: "Orderded\n",state: s.StepState.start,isActive: true));
      statusManagements.add(new StatusManagement(status: "Confirmed\n",state: s.StepState.complete,isActive: true));
      if(status == EnumOrderStatus.getString(OrderStatus.Rejected)){
        statusManagements.add(new StatusManagement(status: "Rejected\n",state: s.StepState.complete,isActive: true));
      }else{
        statusManagements.add(new StatusManagement(status: "Cancelled\n",state: s.StepState.complete,isActive: true));
      }
      statusManagements.add(new StatusManagement(status: "Refunded\n",state: s.StepState.complete,isActive: false));
    }

    return statusManagements;
  }
}