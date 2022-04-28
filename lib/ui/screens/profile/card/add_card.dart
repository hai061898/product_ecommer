import 'package:flutter/material.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class AddCreditCardPage extends StatelessWidget {
  const AddCreditCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Add Cards',
              color: ColorsCustom.primaryColor,
              fontWeight: FontWeight.w600),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: ColorsCustom.primaryColor),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: const Center(
        child: Text('Hola Frave Developer'),
      ),
    );
  }
}
