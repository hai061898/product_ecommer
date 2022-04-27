import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/models/response_products_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/screens/products/details_product_page.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class ListProductsForHome extends StatelessWidget {
  const ListProductsForHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return FutureBuilder<List<ListProducts>>(
      future: productServices.listProductsHome(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Column(
                children: const [
                  ShimmerCustom(),
                  SizedBox(height: 10.0),
                  ShimmerCustom(),
                  SizedBox(height: 10.0),
                  ShimmerCustom(),
                ],
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) => Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsProductPage(
                                product: snapshot.data![i]))),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Hero(
                                  tag: snapshot.data![i].uidProduct.toString(),
                                  child: Image.network(
                                      URLS.baseUrl + snapshot.data![i].picture,
                                      height: 120)),
                            ),
                            TextCustom(
                                text: snapshot.data![i].nameProduct,
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis),
                            TextCustom(
                                text: '\$ ${snapshot.data![i].price}',
                                fontSize: 16),
                          ],
                        ),
                        Positioned(
                            right: 0,
                            child: snapshot.data![i].isFavorite == 1
                                ? InkWell(
                                    onTap: () => productBloc.add(
                                        OnAddOrDeleteProductFavoriteEvent(
                                            uidProduct: snapshot
                                                .data![i].uidProduct
                                                .toString())),
                                    child: const Icon(Icons.favorite_rounded,
                                        color: Colors.red),
                                  )
                                : InkWell(
                                    onTap: () => productBloc.add(
                                        OnAddOrDeleteProductFavoriteEvent(
                                            uidProduct: snapshot
                                                .data![i].uidProduct
                                                .toString())),
                                    child: const Icon(
                                        Icons.favorite_outline_rounded))),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
