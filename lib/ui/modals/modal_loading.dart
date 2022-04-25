import 'package:flutter/material.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

void modalLoading(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                TextCustom(
                    text: 'Star ',
                    color: ColorsCustom.primaryColor,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'Shop', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const CircularProgressIndicator(
                    color: ColorsCustom.primaryColor),
                const SizedBox(width: 15.0),
                TextCustom(text: text)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
