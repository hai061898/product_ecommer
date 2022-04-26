import 'package:flutter/material.dart';
import 'package:product_ecommer/data/models/response_categories_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class ListCategoriesHome extends StatelessWidget {
  const ListCategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Categories>>(
        future: productServices.listCategoriesHome(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const ShimmerCustom()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 150,
                    decoration: BoxDecoration(
                        color: const Color(0xff0C6CF2).withOpacity(.1),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: TextCustom(
                      text: snapshot.data![i].category,
                      color: ColorsCustom.primaryColor,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17,
                    )),
                  ),
                );
        },
      ),
    );
  }
}
