import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_application/core/utils/api_keys.dart';
import 'package:payment_application/core/utils/colored_print.dart';
import 'package:payment_application/core/utils/paymob_service.dart';
import 'package:payment_application/core/widgets/custom_button.dart';
import 'package:payment_application/features/checkout/data/model/amount_model/amount_model.dart';
import 'package:payment_application/features/checkout/data/model/amount_model/details.dart';
import 'package:payment_application/features/checkout/data/model/item_list_model/item.dart';
import 'package:payment_application/features/checkout/data/model/item_list_model/item_list_model.dart';
import 'package:payment_application/features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_application/features/checkout/presentation/manger/payment_cubit/payment_cubit.dart';
import 'package:payment_application/features/checkout/presentation/views/thank_you_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.activeIndex,
  });
  final int activeIndex;
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
          // isLoading: state is PaymentLoading ? true : false,
          onTap: () {
            coloredPrint(message: activeIndex.toString());
            // if (activeIndex == 0) {
            //   stripePayment(context);
            // }
            // else
            // if (activeIndex == 1) {
            //   paypalPayment(context);
            // }
            //  else {
            // pay();
            // }
            // stripePayment(context);
            // paypalPayment(context);
            // pay();
          },
        );
      },
    );
  }

  void stripePayment(BuildContext context) {
    PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
      amount: 1000,
      currency: 'USD',
      customerId: 'cus_QYxjQWI7Hmr9J4',
    );
    context.read<PaymentCubit>().makePayment(
          paymentIntentInputModel: paymentIntentInputModel,
        );
  }

  void paypalPayment(BuildContext context) {
    var transactionData = getTransaction();
    exceutePaypalPayment(context, transactionData);
  }

  Future<dynamic> exceutePaypalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel itemList}) transactionData) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientId,
        secretKey: ApiKeys.payPalSecretKey,
        transactions: [
          {
            "amount": transactionData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ThankYouView()));
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          debugPrint('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({AmountModel amount, ItemListModel itemList}) getTransaction() {
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
      OrderItemModel(currency: "USD", name: "Apple", price: "4", quantity: 10),
      OrderItemModel(currency: "USD", name: "Apple", price: "5", quantity: 12),
    ];
    var itemList = ItemListModel(orders: orders);
    return (amount: amountModel, itemList: itemList);
  }

  Future<void> pay() async {
    PaymobManager().getPaymentKey(10, "EGP").then((String paymentKey) {
      launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/858809?payment_token=$paymentKey"),
      );
    });
  }
}
