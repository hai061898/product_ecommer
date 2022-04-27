import 'package:flutter/material.dart';
import 'package:product_ecommer/data/services/url.dart';

class CoverProduct extends StatelessWidget {
  final String imageProduct;
  final String uidProduct;

  // ignore: use_key_in_widget_constructors
  const CoverProduct({required this.uidProduct, required this.imageProduct});

  @override
  Widget build(BuildContext context) {
    return Hero(
      // ignore: unnecessary_string_interpolations
      tag: '$uidProduct',
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Image.network(URLS.baseUrl + imageProduct),
      ),
    );
  }
}
