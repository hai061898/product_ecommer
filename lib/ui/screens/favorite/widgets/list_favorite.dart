import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/models/response_products_home.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/products/details_product_page.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class ListFavoriteProduct extends StatelessWidget {
  final List<ListProducts> products;

  const ListFavoriteProduct({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 90),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 20,
            mainAxisExtent: 220),
        itemCount: products.length,
        itemBuilder: (context, i) => ProductFavorite(product: products[i]));
  }
}

class ProductFavorite extends StatelessWidget {
  final ListProducts product;

  const ProductFavorite({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return GestureDetector(
      onTap: () => Navigator.push(
          context, routeSlide(page: DetailsProductPage(product: product))),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(URLS.baseUrl + product.picture, height: 120),
                TextCustom(
                    text: product.nameProduct,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10.0),
                TextCustom(
                    text: '\$ ${product.price}',
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ],
            ),
            Positioned(
                right: 0,
                child: InkWell(
                  onTap: () => productBloc.add(
                      OnAddOrDeleteProductFavoriteEvent(
                          uidProduct: product.uidProduct.toString())),
                  child: const Icon(Icons.favorite_rounded, color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}
