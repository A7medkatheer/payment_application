class InitPaymentSheetInputModel {
  final String ephemeralKeySecret;
  final String clientSecret;
  final String customerId;

  InitPaymentSheetInputModel({
    required this.clientSecret,
    required this.customerId,
    required this.ephemeralKeySecret,
  });
}
