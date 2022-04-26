import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/general/general_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading_short.dart';
import 'package:product_ecommer/ui/screens/categories/categories_page.dart';
import 'package:product_ecommer/ui/widgets/bottom_nav.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

import 'widgets/carousel_home.dart';
import 'widgets/head_home.dart';
import 'widgets/list_categories_home.dart';
import 'widgets/list_products_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backgroundColor: const Color(0xfff5f5f5),
        body: Stack(
          children: [
            ListHome(),
            Positioned(
              bottom: 20,
              child: SizedBox(
                  width: size.width,
                  child: const Align(
                      alignment: Alignment.center,
                      child: BottomNavigationCustom(index: 1))),
            ),
          ],
        ),
      ),
    );
  }
}

class ListHome extends StatefulWidget {
  const ListHome({Key? key}) : super(key: key);

  @override
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  late ScrollController _scrollControllerHome;
  double scrollPrevious = 0;

  @override
  void initState() {
    _scrollControllerHome = ScrollController();
    _scrollControllerHome.addListener(addListenerMenu);
    super.initState();
  }

  void addListenerMenu() {
    if (_scrollControllerHome.offset > scrollPrevious) {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: false));
    } else {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: true));
    }

    scrollPrevious = _scrollControllerHome.offset;
  }

  @override
  void dispose() {
    _scrollControllerHome.removeListener(addListenerMenu);
    _scrollControllerHome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        controller: _scrollControllerHome,
        children: [
          const HeaderHome(),
          const SizedBox(height: 10.0),
          const CardCarousel(),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(
                text: 'Categories',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(routeSlide(page: CategoriesPage())),
                child: Row(
                  children: const [
                    TextCustom(text: 'See All', fontSize: 17),
                    SizedBox(width: 5.0),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 18, color: Color(0xff006CF2))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          const ListCategoriesHome(),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextCustom(
                text: 'Popular Products',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: const [
                  TextCustom(text: 'See All', fontSize: 17),
                  SizedBox(width: 5.0),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: 18, color: Color(0xff006CF2))
                ],
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          const ListProductsForHome()
        ],
      ),
    );
  }
}
