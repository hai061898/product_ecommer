import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/home/home_page.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class WithoutProductsCart extends StatelessWidget {
  const WithoutProductsCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) => state.products != null
            ? state.products!.isNotEmpty
                ? SizedBox(
                    height: 290,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,
                            size: 90,
                            color: ColorsCustom.primaryColor.withOpacity(.7)),
                        const SizedBox(height: 20),
                        const TextCustom(
                            text: 'There is a cart to fill!',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        const SizedBox(height: 20),
                        const TextCustom(
                            text: 'Currently do not have ', fontSize: 16),
                        const SizedBox(height: 5),
                        const TextCustom(
                            text: 'any products in your shopping cart',
                            fontSize: 16),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.blue)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10))),
                            child: const TextCustom(
                                text: 'Go Products', fontSize: 19),
                            onPressed: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    routeSlide(page: const HomePage()), (_) => false),
                          ),
                        )
                      ],
                    ))
                : const SizedBox()
            : const ShimmerCustom());
  }
}
