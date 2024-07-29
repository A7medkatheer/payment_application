import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_application/core/utils/colored_print.dart';
import 'package:payment_application/core/widgets/custom_button.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_application/features/checkout/presentation/manger/payment_cubit/payment_cubit.dart';
import 'package:payment_application/features/checkout/presentation/views/thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            // ignore: avoid_redundant_argument_values
            MaterialPageRoute(builder: (context) {
              return const ThankYouView();
            }),
          );
        }
        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          coloredPrint(message: state.message);
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
          onTap: () {
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //   amount: 1000,
            //   currency: 'USD',
            //   customerId: 'cus_QYxjQWI7Hmr9J4',
            // );
            // context.read<PaymentCubit>().makePayment(
            //       paymentIntentInputModel: paymentIntentInputModel,
            //     );

            PaypalCheckoutView(
              sandboxMode: true,
              clientId: "YOUR CLIENT ID",
              secretKey: "YOUR SECRET KEY",
              transactions: const [
                {
                  "amount": {
                    "total": '100',
                    "currency": "USD",
                    "details": {
                      "subtotal": '100',
                      "shipping": '0',
                      "shipping_discount": 0
                    }
                  },
                  "description": "The payment transaction description.",
                  // "payment_options": {
                  //   "allowed_payment_method":
                  //       "INSTANT_FUNDING_SOURCE"
                  // },
                  "item_list": {
                    "items": [
                      {
                        "name": "Apple",
                        "quantity": 4,
                        "price": '10',
                        "currency": "USD"
                      },
                      {
                        "name": "Pineapple",
                        "quantity": 5,
                        "price": '12',
                        "currency": "USD"
                      }
                    ],

                    // Optional
                    //   "shipping_address": {
                    //     "recipient_name": "Tharwat samy",
                    //     "line1": "tharwat",
                    //     "line2": "",
                    //     "city": "tharwat",
                    //     "country_code": "EG",
                    //     "postal_code": "25025",
                    //     "phone": "+00000000",
                    //     "state": "ALex"
                    //  },
                  }
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                log("onSuccess: $params");
                Navigator.pop(context);
              },
              onError: (error) {
                log("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                print('cancelled:');
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
