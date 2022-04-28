import 'package:flutter/material.dart';
import 'package:product_ecommer/data/models/response_order_buy.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'order_details_page.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Purchased',
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 20),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<OrderBuy>>(
        future: productServices.getPurchasedProducts(),
        builder: (_, snapshot) {
          return (!snapshot.hasData)
              ? const ShimmerCustom()
              : _DetailsProductsBuy(ordersBuy: snapshot.data!);
        },
      ),
    );
  }
}

class _DetailsProductsBuy extends StatelessWidget {
  final List<OrderBuy> ordersBuy;

  const _DetailsProductsBuy({Key? key, required this.ordersBuy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      itemCount: ordersBuy.length,
      itemBuilder: (_, i) => InkWell(
        onTap: () => Navigator.push(
            context,
            routeSlide(
                page: OrderDetailsPage(
                    uidOrder: ordersBuy[i].uidOrderBuy.toString()))),
        child: Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                  text: ordersBuy[i].receipt,
                  fontSize: 21,
                  color: ColorsCustom.primaryColor,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                      text: 'Date ', fontSize: 18, color: Colors.grey),
                  TextCustom(
                      text:
                          timeago.format(ordersBuy[i].createdAt, locale: 'es'),
                      fontSize: 18),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                      text: 'Amount ', fontSize: 18, color: Colors.grey),
                  TextCustom(
                      text: '\$ ${ordersBuy[i].amount}',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
