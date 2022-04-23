import 'package:product_ecommer/data/models/credit_card_model.dart';

final List<CreditCard> cards = [
  CreditCard(
      cardNumberHidden: '9999',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '123',
      expiracyDate: '01/25',
      cardHolderName: 'Star'),
  CreditCard(
      cardNumberHidden: '5555',
      cardNumber: '5555555555554444',
      brand: 'mastercard',
      cvv: '213',
      expiracyDate: '04/23',
      cardHolderName: 'Star 1'),
  CreditCard(
      cardNumberHidden: '7777',
      cardNumber: '378282246310005',
      brand: 'american express',
      cvv: '2134',
      expiracyDate: '04/23',
      cardHolderName: 'Star 2'),
];
