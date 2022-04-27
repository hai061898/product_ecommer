import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/bloc/cart/cart_bloc.dart';
import 'package:product_ecommer/data/data_fake/list_credit_card.dart';
import 'package:product_ecommer/data/models/credit_card_model.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class PaymentCardPage extends StatelessWidget {
  const PaymentCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Payment',
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const TextCustom(
                text: 'Add Card',
                color: ColorsCustom.primaryColor,
                fontSize: 17),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: cards.length,
        itemBuilder: (_, i) {
          final CreditCard card = cards[i];

          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => GestureDetector(
              onTap: () => cartBloc.add(OnSelectCardEvent(card)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.all(10.0),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: state.creditCard == null
                            ? Colors.black
                            : state.creditCard!.cvv == card.cvv
                                ? Colors.blue
                                : Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: SvgPicture.asset('Assets/${card.brand}.svg')),
                    SizedBox(
                        child: TextCustom(
                            text: '**** **** **** ${card.cardNumberHidden}')),
                    Container(
                        child: state.creditCard == null
                            ? const Icon(Icons.radio_button_off_rounded,
                                size: 31)
                            : state.creditCard!.cvv == card.cvv
                                ? const Icon(
                                    Icons.radio_button_checked_rounded,
                                    size: 31,
                                    color: Colors.blue,
                                  )
                                : const Icon(Icons.radio_button_off_rounded,
                                    size: 31))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
