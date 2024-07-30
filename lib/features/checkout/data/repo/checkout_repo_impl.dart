import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_application/core/errors/exceptions.dart';
import 'package:payment_application/core/utils/stripe_service.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_application/features/checkout/data/repo/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } on StripeException catch (e) {
      return left(e.error.localizedMessage.toString());
    } on ServerException catch (e) {
      return left(e.errModel.message.toString());
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }
}
