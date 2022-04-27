import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/data/models/response_products_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading_short.dart';
import 'package:product_ecommer/ui/screens/favorite/widgets/list_favorite.dart';
import 'package:product_ecommer/ui/widgets/bottom_nav.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
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
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          title: const TextCustom(
              text: 'Favorites',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500),
          centerTitle: true,
          backgroundColor: const Color(0xfff2f2f2),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            FutureBuilder<List<ListProducts>>(
                future: productServices.allFavoriteProducts(),
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
                    : ListFavoriteProduct(products: snapshot.data!)),
            Positioned(
              bottom: 20,
              child: SizedBox(
                  width: size.width,
                  child: const Align(child: BottomNavigationCustom(index: 2))),
            ),
          ],
        ),
      ),
    );
  }
}
