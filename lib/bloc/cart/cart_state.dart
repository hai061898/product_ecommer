part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  final String totalAmount;
  final String currency;
  final bool? cardActive;
  final CreditCard? creditCard;

  const CartState(
      {this.totalAmount = '00.0',
      this.currency = 'USD',
      this.cardActive,
      this.creditCard});
}

class CartInitial extends CartState {
  const CartInitial() : super(cardActive: false);
}

class LoadingPaymentState extends CartState {}

class SuccessPaymentState extends CartState {}

class FailurePaymentState extends CartState {
  final String err;

  const FailurePaymentState(this.err);
}

class SetActiveCardState extends CartState {
  final bool active;
  @override
  // ignore: overridden_fields
  final CreditCard creditCard;

  const SetActiveCardState({required this.active, required this.creditCard})
      : super(cardActive: active, creditCard: creditCard);
}
