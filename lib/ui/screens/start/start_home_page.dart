import 'package:flutter/material.dart';
import 'package:product_ecommer/ui/widgets/btn_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class StartHomePage extends StatelessWidget {
  const StartHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff1E4DD8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 180,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Assets/logo-white.png')))),
                      const SizedBox(height: 15.0),
                      const TextCustom(
                          text: 'FRAVE SHOP',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      const TextCustom(
                          text: 'All your products in your hands',
                          fontSize: 20,
                          color: Colors.white70),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      BtnCustom(
                          text: 'Sign Up with Email ID',
                          colorText: Colors.white,
                          backgroundColor: const Color(0xff1C2834),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('signUpPage'),
                          width: size.width),
                      const SizedBox(height: 15.0),
                      BtnCustom(
                          text: 'Sign Up with Google',
                          colorText: Colors.black87,
                          fontSize: 19,
                          backgroundColor: const Color(0xFFE9EFF9),
                          width: size.width),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextCustom(
                              text: 'Already have an account?', fontSize: 17),
                          TextButton(
                            child: const TextCustom(
                                text: 'Sign In',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('signInPage'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
