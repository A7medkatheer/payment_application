
import 'package:dartz/dartz.dart';
import 'package:payment_application/core/errors/failures.dart';
import 'package:payment_application/core/utils/stripe_service.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_application/features/checkout/data/repo/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } catch (e) {
     return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
