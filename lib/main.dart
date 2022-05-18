import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/auth/auth_bloc.dart';
import 'package:product_ecommer/bloc/cart/cart_bloc.dart';
import 'package:product_ecommer/bloc/category/category_bloc.dart';
import 'package:product_ecommer/bloc/general/general_bloc.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/bloc/user/user_bloc.dart';
import 'package:product_ecommer/ui/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commers Products',
        initialRoute: 'loadingPage',
        routes: routes,
      ),
    );
  }
}
