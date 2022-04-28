import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/data/data_fake/list_credit_card.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

import 'add_card.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'My Cards',
            color: ColorsCustom.primaryColor,
            fontWeight: FontWeight.w600),
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: ColorsCustom.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.add_circle_outline_rounded,
                    color: ColorsCustom.primaryColor, size: 17),
                const SizedBox(width: 5.0),
                GestureDetector(
                  child: const TextCustom(
                      text: 'Add Card',
                      color: ColorsCustom.primaryColor,
                      fontSize: 15),
                  onTap: () => Navigator.of(context)
                      .push(routeSlide(page: const AddCreditCardPage())),
                ),
                const SizedBox(width: 7.0),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: .9),
                physics: const BouncingScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (_, i) {
                  final card = cards[i];

                  return _CreditCard(
                    cardHolderName: card.cardHolderName,
                    cardNumber: card.cardNumber,
                    expiryDate: card.expiracyDate,
                    cvvCode: card.cvv,
                    brand: card.brand,
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const TextCustom(text: 'Last movements', fontSize: 19),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String brand;

  const _CreditCard(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      margin: const EdgeInsets.only(right: 15.0),
      height: 220,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xFF3A4960)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('Assets/card-chip.png', height: 60),
              SvgPicture.asset('Assets/$brand.svg', height: 80)
            ],
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextCustom(
                text: cardNumber,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(
                    text: cardHolderName, fontSize: 23, color: Colors.white),
                TextCustom(text: expiryDate, color: Colors.white, fontSize: 19),
              ],
            ),
          )
        ],
      ),
    );
  }
}
