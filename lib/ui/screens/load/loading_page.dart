import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_ecommer/bloc/auth/auth_bloc.dart';
import 'package:product_ecommer/bloc/user/user_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/home/home_page.dart';
import 'package:product_ecommer/ui/screens/start/start_home_page.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);

    _animation.addStatusListener(_animationListener);

    _animationController.forward();
  }

  _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeStatusListener(_animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogOutState) {
          Navigator.of(context).pushAndRemoveUntil(
              routeFade(page: StartHomePage()), (_) => false);
        } else if (state is SuccessAuthState) {
          userBloc.add(OnGetUserEvent());
          Navigator.of(context)
              .pushAndRemoveUntil(routeSlide(page: HomePage()), (_) => false);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff1E4DD8),
        body: Center(
            child: SizedBox(
          height: 212,
          width: 181,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) => Transform.scale(
                  scale: _animation.value,
                  child: Image.asset('Assets/logo-white.png'),
                ),
              ),
              const SizedBox(height: 10.0),
              const TextCustom(
                  text: 'Verifying your device...', color: Colors.white60)
            ],
          ),
        )),
      ),
    );
  }
}