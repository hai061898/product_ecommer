import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/data/models/response_categories_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

import 'product_for_category_page.dart';

class CategoriesPage extends StatelessWidget {

  const CategoriesPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: const TextCustom(text: 'Categories', color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 20),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Categories>>(
         future: productServices.getAllCategories(),
         builder: (context, snapshot){
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
            : _ListCategories(categories: snapshot.data!);
         },
      ),
     );
  }
}


class _ListCategories extends StatelessWidget {
  
  final List<Categories> categories;

  const _ListCategories({ Key? key, required this.categories}): super(key: key); 

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 180
      ),
      itemCount: categories.length,
      itemBuilder: (context, i) => GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: ColorsCustom.primaryColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.network(URLS.baseUrl+ categories[i].picture, height: 85, color: ColorsCustom.primaryColor),
              const SizedBox(height: 10.0),
              TextCustom(text: categories[i].category, fontSize: 20, overflow: TextOverflow.ellipsis )
            ],
          ),
        ),
        onTap: () => Navigator.push(context, routeSlide(page: CategoryProductsPage(uidCategory: categories[i].uidCategory.toString(), category: categories[i].category)))
      ),
    );
  }
}