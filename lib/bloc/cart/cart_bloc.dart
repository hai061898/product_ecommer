import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:product_ecommer/data/models/credit_card_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<OnSelectCardEvent>(_selectCard);
    on<OnMakePaymentEvent>(_makePayment);
  }

  Future<void> _selectCard(
      OnSelectCardEvent event, Emitter<CartState> emit) async {
    emit(SetActiveCardState(active: true, creditCard: event.creditCard));
  }

  Future<void> _makePayment(
      OnMakePaymentEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingPaymentState());
    } catch (e) {
      emit(FailurePaymentState(e.toString()));
    }
  }
}
