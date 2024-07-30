import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_application/core/utils/colored_print.dart';
import 'package:payment_application/core/widgets/custom_button.dart';
import 'package:payment_application/features/checkout/data/model/amount_model/amount_model.dart';
import 'package:payment_application/features/checkout/data/model/amount_model/details.dart';
import 'package:payment_application/features/checkout/data/model/item_list_model/item.dart';
import 'package:payment_application/features/checkout/data/model/item_list_model/item_list_model.dart';
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
            var amountModel = AmountModel(
              total: '100',
              currency: 'USD',
              details: Details(
                shipping: '0',
                shippingDiscount: 0,
                subtotal: '100',
              ),
            );
            List<OrderItemModel> orders = [
              OrderItemModel(
                  currency: "USD", name: "Apple", price: "4", quantity: 10),
              OrderItemModel(
                  currency: "USD", name: "Apple", price: "5", quantity: 12),
            ];
            var itemList = ItemListModel(orders: orders);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId: "YOUR CLIENT ID",
                secretKey: "YOUR SECRET KEY",
                transactions: [
                  {
                    "amount": amountModel.toJson(),
                    "description": "The payment transaction description.",
                    "item_list": itemList.toJson(),
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
              ),
            ));
          },
        );
      },
    );
  }
}
