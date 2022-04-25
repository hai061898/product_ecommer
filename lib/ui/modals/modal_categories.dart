import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/category/category_bloc.dart';
import 'package:product_ecommer/data/models/response_categories_home.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

modalCategoies(BuildContext context, Size size) {
  final categoryBloc = BlocProvider.of<CategoryBloc>(context);

  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black38,
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: size.height * .6,
      width: size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            const SizedBox(height: 20.0),
            const TextCustom(text: 'Select Category'),
            const SizedBox(height: 20.0),
            Expanded(
                child: FutureBuilder<List<Categories>>(
                    future: productServices.getAllCategories(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) => InkWell(
                              onTap: () => categoryBloc.add(
                                  OnSelectUidCategoryEvent(
                                      snapshot.data![i].uidCategory,
                                      snapshot.data![i].category)),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 10.0),
                                  height: 45,
                                  width: size.width,
                                  // color: Colors.grey[100],
                                  child:
                                      BlocBuilder<CategoryBloc, CategoryState>(
                                    builder: (context, state) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextCustom(
                                            text: snapshot.data![i].category),
                                        state.uidCategory ==
                                                snapshot.data![i].uidCategory
                                            ? const Icon(Icons.check_rounded,
                                                color: ColorsCustom
                                                    .primaryColor)
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const ShimmerCustom()))
          ],
        ),
      ),
    ),
  );
}
