
class ProceedToPaymentModel
{
  String ContactId;

  int PaymentMethod;

  String GatewayOrderId;

  String TransactionId;

  ProceedToPaymentModel({
    this.ContactId,
    this.PaymentMethod,
    this.GatewayOrderId,
    this.TransactionId,
  });

  factory ProceedToPaymentModel.fromJson(Map<String, dynamic> parsedData) {
    return ProceedToPaymentModel(
      ContactId: parsedData['ContactId'],
      PaymentMethod: parsedData['PaymentMethod'],
      GatewayOrderId: parsedData['GatewayOrderId'],
      TransactionId: parsedData['TransactionId'],
    );
  }
}