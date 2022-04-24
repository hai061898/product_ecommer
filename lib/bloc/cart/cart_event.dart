part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnSelectCardEvent extends CartEvent {
  final CreditCard creditCard;

  OnSelectCardEvent(this.creditCard);
}

class OnCancelCart extends CartEvent {}

class OnMakePaymentEvent extends CartEvent {
  final String amount;
  final CreditCard creditCard;

  OnMakePaymentEvent({required this.amount, required this.creditCard});
}
