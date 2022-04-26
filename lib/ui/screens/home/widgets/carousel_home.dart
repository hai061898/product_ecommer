import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product_ecommer/data/models/response_slide_products.dart';
import 'package:product_ecommer/data/services/product_services.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/widgets/shimmer_c.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<SlideProduct>>(
          future: productServices.listProductsHomeCarousel(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const ShimmerCustom()
                : CarouselSlider.builder(
                    itemCount: snapshot.data!.length,
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 1,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(URLS.baseUrl +
                                    snapshot.data![index].image))),
                      );
                    },
                  );
          }),
    );
  }
}
