import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/models/product_cart_model.dart';
import 'package:product_ecommer/data/models/response_products_home.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading_short.dart';
import 'package:product_ecommer/ui/modals/modal_success.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

import 'widgets/app_bar_product.dart';
import 'widgets/cover_product.dart';
import 'widgets/rating_product.dart';

class DetailsProductPage extends StatefulWidget {
  final ListProducts product;

  // ignore: use_key_in_widget_constructors
  const DetailsProductPage({required this.product});

  @override
  State<DetailsProductPage> createState() => _DetailsProductPageState();
}

class _DetailsProductPageState extends State<DetailsProductPage> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoadingShort(context);
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          setState(() {});
        } else if (state is SetAddProductToCartState) {
          modalSuccess(context, 'Product Added',
              onPressed: () => Navigator.pop(context));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(top: 10.0, bottom: 100.0),
                children: [
                  AppBarProduct(
                      nameProduct: widget.product.nameProduct,
                      uidProduct: widget.product.uidProduct.toString(),
                      isFavorite: widget.product.isFavorite),
                  const SizedBox(height: 20.0),
                  CoverProduct(
                      uidProduct: widget.product.uidProduct.toString(),
                      imageProduct: widget.product.picture),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      children: [
                        TextCustom(
                            text: widget.product.nameProduct,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const RatingProduct(),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SvgPicture.asset('Assets/garantia.svg',
                                color: Colors.green, height: 50),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'This product has a ',
                                    style: GoogleFonts.getFont('Roboto',
                                        color: Colors.black, fontSize: 18)),
                                TextSpan(
                                    text: 'delivery guarantee',
                                    style: GoogleFonts.getFont('Roboto',
                                        color: Colors.blue, fontSize: 18))
                              ]),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 215),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: const Color(0xff8956FF),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const TextCustom(
                          text: 'Shipping normally',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      child: Row(
                        children: const [
                          TextCustom(
                              text: 'Available. ',
                              fontSize: 18,
                              color: Colors.green),
                          TextCustom(
                            text: 'In Stock',
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextCustom(
                        text: 'Description',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      children: [
                        TextCustom(
                            text: widget.product.description, fontSize: 17)
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextCustom(
                        text: 'Payment methods',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 60,
                    color: const Color(0xfff5f5f5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'Assets/visa.svg',
                          height: 60,
                          color: Colors.blue,
                        ),
                        SvgPicture.asset(
                          'Assets/mastercard.svg',
                          height: 60,
                        ),
                        SvgPicture.asset(
                          'Assets/american express.svg',
                          height: 60,
                        ),
                        SvgPicture.asset('Assets/paypal.svg', height: 55),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 15,
                        spreadRadius: 15)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: size.width * .45,
                        child: TextCustom(
                            text: '\$ ${widget.product.price}',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(width: 15.0),
                      Container(
                        height: 55,
                        width: size.width * .45,
                        decoration: BoxDecoration(
                            color: ColorsCustom.primaryColor,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          child: const TextCustom(
                              text: 'Add to cart',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          onPressed: () {
                            final productSelect = ProductCart(
                                uidProduct:
                                    widget.product.uidProduct.toString(),
                                image: widget.product.picture,
                                name: widget.product.nameProduct,
                                price: widget.product.price.toDouble(),
                                amount: 1);

                            productBloc
                                .add(OnAddProductToCartEvent(productSelect));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
