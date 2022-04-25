import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

void modalAddCartSuccess( BuildContext context, String image ){

  showDialog(
    context: context,
    barrierColor: Colors.white60,
    builder: (context) {
      return BounceInDown(
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SizedBox(
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextCustom(text: 'Shop', fontSize: 22, color: ColorsCustom.primaryColor, fontWeight: FontWeight.w500),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(URLS.baseUrl + image, height: 80.0,),
                    const SizedBox(width: 10.0),
                    BounceInLeft(child: const Icon(Icons.check_circle_outlined, color: Colors.green, size: 80 )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

}