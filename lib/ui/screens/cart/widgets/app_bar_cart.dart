import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/home/home_page.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class AppBarCart extends StatelessWidget {
  const AppBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xffF5F5F5),
                radius: 24,
                child: InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        routeSlide(page: const HomePage()), (_) => false),
                    child: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black)),
              ),
              const SizedBox(width: 20.0),
              const SizedBox(
                  child: TextCustom(
                      text: 'My Cart',
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (_, state) => state.products != null
                      ? TextCustom(
                          text: '${state.products!.length} items',
                          fontSize: 19,
                          color: Colors.black54)
                      : const TextCustom(
                          text: '0 items',
                          fontSize: 19,
                          color: Colors.black54))),
        ],
      ),
    );
  }
}
