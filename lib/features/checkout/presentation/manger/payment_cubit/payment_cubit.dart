import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment_application/core/utils/colored_print.dart';
import 'package:payment_application/core/utils/paymob_service.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_application/features/checkout/data/repo/checkout_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    final data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold(
      (failure) => emit(
        PaymentFailure(message: failure),
      ),
      (_) => emit(
        PaymentSuccess(),
      ),
    );
  }

  Future<void> paymobPayment() async {
    emit(PaymobPaymentLoading());
    await PaymobManager().getPaymentKey(10, "EGP").then((String paymentKey) {
      launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/858809?payment_token=$paymentKey"),
      );
    });
    emit(PaymobPaymentSuccess());
  }

  @override
  void onChange(Change<PaymentState> change) {
    coloredPrint(message: change.toString());
    // log(change.toString());
    super.onChange(change);
  }
}
