import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      height: 130,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(
                text: 'Order',
                fontSize: 19,
              ),
              TextCustom(
                text: '\$ ${productBloc.state.total}',
                fontSize: 19,
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(
                text: 'Delivery',
                fontSize: 19,
              ),
              TextCustom(
                text: '\$ ${productBloc.state.delivery}',
                fontSize: 19,
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(
                text: 'Insurance',
                fontSize: 19,
              ),
              TextCustom(
                text: '\$ ${productBloc.state.insurance}',
                fontSize: 19,
              )
            ],
          ),
        ],
      ),
    );
  }
}
