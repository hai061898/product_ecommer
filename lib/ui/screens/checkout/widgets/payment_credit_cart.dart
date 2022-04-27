import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/bloc/cart/cart_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/payment/payment_card_page.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class PaymentCreditCart extends StatelessWidget {
  const PaymentCreditCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 113,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextCustom(
                    text: 'Payment', fontSize: 19, fontWeight: FontWeight.w600),
                GestureDetector(
                    child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) => (!state.cardActive!)
                            ? const TextCustom(
                                text: 'Add', color: Colors.blue, fontSize: 18)
                            : const TextCustom(
                                text: 'Change',
                                color: Colors.blue,
                                fontSize: 18)),
                    onTap: () => Navigator.push(
                        context, routeSlide(page: const PaymentCardPage())))
              ],
            ),
            const Divider(),
            const SizedBox(height: 5.0),
            BlocBuilder<CartBloc, CartState>(
                builder: (_, state) => (!state.cardActive!)
                    ? const TextCustom(
                        text: 'Without Credit Card', fontSize: 18)
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        color: const Color(0xfff5f5f5),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                    'Assets/${state.creditCard!.brand}.svg')),
                            const SizedBox(width: 15.0),
                            TextCustom(
                              text:
                                  '**** **** **** ${state.creditCard!.cardNumberHidden}',
                              fontSize: 18,
                            )
                          ],
                        ),
                      ))
          ],
        ));
  }
}
