import 'package:flutter/material.dart';
import 'package:product_ecommer/ui/screens/load/loading_page.dart';
import 'package:product_ecommer/ui/screens/login/login_page.dart';
import 'package:product_ecommer/ui/screens/register/register_page.dart';
import 'package:product_ecommer/ui/screens/start/start_home_page.dart';

Map<String, Widget Function(BuildContext context)> routes = {

    'loadingPage'   : ( context ) => const LoadingPage(),
    'getStarted'    : ( context ) => const StartHomePage(),
    'signInPage'    : ( context ) => const SignInPage(),
    'signUpPage'    : ( context ) => const SignUpPage(),
};