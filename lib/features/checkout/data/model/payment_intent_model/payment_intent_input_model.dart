class PaymentIntentInputModel {
  final String currency;
  final int amount;
  final String customerId;

  PaymentIntentInputModel({
    required this.customerId,
    required this.currency,
    required this.amount,
  });

  toJson() {
    return {
      'currency': currency,
      'amount': "${amount}00",
      'customer': customerId,
    };
  }
}
