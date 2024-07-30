import 'package:dartz/dartz.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<String, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
