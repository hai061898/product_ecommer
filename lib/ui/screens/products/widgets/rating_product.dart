import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class RatingProduct extends StatelessWidget {
  const RatingProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 160,
            child: RatingBarIndicator(
              rating: 4,
              itemCount: 5,
              itemSize: 30.0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
            ),
          ),
          const TextCustom(
              text: '999 Reviews', fontSize: 17, color: Colors.grey)
        ],
      ),
    );
  }
}
