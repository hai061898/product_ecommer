import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading.dart';
import 'package:product_ecommer/ui/modals/modal_success.dart';
import 'package:product_ecommer/ui/screens/cart/widgets/order_details.dart';
import 'package:product_ecommer/ui/screens/home/home_page.dart';
import 'package:product_ecommer/ui/widgets/btn_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          modalSuccess(context, 'Successfully paid', onPressed: () {
            productBloc.add(OnClearProductsEvent());
            Navigator.pushAndRemoveUntil(
                context, routeFade(page: const HomePage()), (_) => false);
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff3f4f8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Checkout',
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          children: [
            const StreetAddressCheckout(),
            const PaymentCreditCart(),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.all(15.0),
              height: 100,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextCustom(
                      text: 'Delivery Details',
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                  Divider(),
                  TextCustom(text: 'Stander Delivery (3-4 days)', fontSize: 18),
                ],
              ),
            ),
            PromoCode(size: size.width),
            const OrderDetails(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                    text: 'Total',
                    fontSize: 19,
                  ),
                  TextCustom(
                    text: '\$ ${productBloc.state.total}',
                    fontSize: 19,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              alignment: Alignment.bottomCenter,
              child: BtnCustom(
                text: 'Pay',
                height: 55,
                fontSize: 22,
                width: size.width,
                onPressed: () {
                  // cartBloc.add( OnMakePayment(amount: '${ (productBloc.state.total * 100 ).floor() }', creditCardFrave: cartBloc.state.creditCardFrave ) );
                  productBloc.add(OnSaveProductsBuyToDatabaseEvent(
                      '${productBloc.state.total}', productBloc.product));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
