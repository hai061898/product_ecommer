import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/models/response_products_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading_short.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/staggered_dual_view.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class CategoryProductsPage extends StatefulWidget {
  final String uidCategory;
  final String category;

  // ignore: use_key_in_widget_constructors
  const CategoryProductsPage(
      {required this.uidCategory, required this.category});

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

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
        }
      },
      child: Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            title: TextCustom(
                text: widget.category,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: FutureBuilder<List<ListProducts>>(
            future:
                productServices.getProductsForCategories(widget.uidCategory),
            builder: (context, snapshot) => !snapshot.hasData
                ? Column(
                    children: const [
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StaggeredDualView(
                        itemCount: snapshot.data!.length,
                        spacing: 5,
                        alturaElement: 0.15,
                        aspectRatio: 0.8,
                        itemBuilder: (context, i) => Card(
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 10.0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.blue[300],
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => DetailsProductPage(
                                            product: snapshot.data![i]))),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Hero(
                                                tag: snapshot
                                                    .data![i].uidProduct
                                                    .toString(),
                                                child: Image.network(
                                                    URLS.baseUrl +
                                                        snapshot
                                                            .data![i].picture,
                                                    height: 120)),
                                          ),
                                          const SizedBox(height: 10.0),
                                          TextCustom(
                                              text:
                                                  snapshot.data![i].nameProduct,
                                              fontWeight: FontWeight.w500),
                                          TextCustom(
                                              text:
                                                  '\$ ${snapshot.data![i].price}',
                                              fontSize: 16),
                                        ],
                                      ),
                                      Positioned(
                                          right: 0,
                                          child: snapshot.data![i].isFavorite ==
                                                  1
                                              ? InkWell(
                                                  onTap: () => productBloc.add(
                                                      OnAddOrDeleteProductFavoriteEvent(
                                                          uidProduct: snapshot
                                                              .data![i]
                                                              .uidProduct
                                                              .toString())),
                                                  child: const Icon(
                                                      Icons.favorite_rounded,
                                                      color: Colors.red),
                                                )
                                              : InkWell(
                                                  onTap: () => productBloc.add(
                                                      OnAddOrDeleteProductFavoriteEvent(
                                                          uidProduct: snapshot
                                                              .data![i]
                                                              .uidProduct
                                                              .toString())),
                                                  child: const Icon(Icons
                                                      .favorite_outline_rounded))),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
          )),
    );
  }
}
