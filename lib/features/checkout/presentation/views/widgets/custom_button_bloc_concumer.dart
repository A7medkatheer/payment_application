import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        }
      },
      builder: (context, state) {
        return  CustomButton(
          text: 'Continue',
          isLoading:  state is PaymentLoading? true : false,
          onTap: () {
              PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
                amount: 1000,
                currency: 'USD',
              );
            context.read<PaymentCubit>().makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
        );
      },
    );
  }
}
