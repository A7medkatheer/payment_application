import 'package:flutter/material.dart';
import 'package:payment_application/core/utils/colored_print.dart';
import 'package:payment_application/features/checkout/presentation/views/widgets/custom_button_bloc_concumer.dart';
import 'package:payment_application/features/checkout/presentation/views/widgets/payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  const PaymentMethodsListView({
    super.key,
  });

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<String> paymentMethodsItems = const [
    'assets/images/card.svg',
    'assets/images/paypal.svg',
    'assets/images/master_card.svg'
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 62,
          child: ListView.builder(
              itemCount: paymentMethodsItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      activeIndex = index;
                      coloredPrint(message: activeIndex.toString());
                      setState(() {});
                    },
                    child: PaymentMethodItem(
                      isActive: activeIndex == index,
                      image: paymentMethodsItems[index],
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 32,
        ),
        CustomButtonBlocConsumer(
          activeIndex: activeIndex,
        ),
      ],
    );
  }
}
