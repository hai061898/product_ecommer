import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class AppBarProduct extends StatelessWidget {
  final String nameProduct;
  final String uidProduct;
  final int isFavorite;

  const AppBarProduct(
      {Key? key,
      required this.nameProduct,
      required this.uidProduct,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () => Navigator.pop(context),
          child: const CircleAvatar(
            backgroundColor: Color(0xffF3F4F6),
            radius: 24,
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          ),
        ),
        SizedBox(
            width: 250,
            child: TextCustom(
                text: nameProduct,
                overflow: TextOverflow.ellipsis,
                fontSize: 19,
                color: Colors.grey)),
        CircleAvatar(
          backgroundColor: const Color(0xffF5F5F5),
          radius: 24,
          child: IconButton(
            icon: isFavorite == 1
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border_rounded,
                    color: Colors.black),
            onPressed: () => productBloc
                .add(OnAddOrDeleteProductFavoriteEvent(uidProduct: uidProduct)),
          ),
        ),
      ],
    );
  }
}
