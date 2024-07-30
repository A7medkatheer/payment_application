part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymobPaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymobPaymentSuccess extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure({required this.message});
}
