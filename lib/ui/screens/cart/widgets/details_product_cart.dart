import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class DetailsProductsCart extends StatelessWidget {
  const DetailsProductsCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) => state.products != null
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.products!.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(15.0),
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xffF5F5F5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: TextCustom(
                                        text: state.products![i].name,
                                        fontSize: 19,
                                        overflow: TextOverflow.ellipsis)),
                                GestureDetector(
                                    onTap: () => productBloc
                                        .add(OnDeleteProductToCartEvent(i)),
                                    child: const Icon(Icons.close,
                                        color: Colors.red, size: 25))
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.network(URLS.baseUrl +
                                        state.products![i].image)),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    TextCustom(
                                        text: '\$ ${state.products![i].price}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    const SizedBox(height: 20.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .55,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.0))),
                                              child: const Icon(Icons.remove,
                                                  color: ColorsCustom
                                                      .primaryColor),
                                            ),
                                            onTap: () {
                                              if (state.products![i].amount >
                                                  1) {
                                                productBloc.add(
                                                    OnSubtractQuantityProductEvent(
                                                        i));
                                              }
                                            },
                                          ),
                                          Container(
                                            height: 35,
                                            width: 35,
                                            color: Colors.white,
                                            child: Center(
                                                child: TextCustom(
                                                    text:
                                                        '${state.products![i].amount}',
                                                    fontSize: 18)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              productBloc.add(
                                                  OnPlusQuantityProductEvent(
                                                      i));
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0))),
                                              child: const Icon(Icons.add,
                                                  color: ColorsCustom
                                                      .primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const ShimmerCustom()),
      ),
    );
  }
}
