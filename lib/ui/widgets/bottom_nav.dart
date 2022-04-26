import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/bloc/general/general_bloc.dart';
import 'package:product_ecommer/bloc/user/user_bloc.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/home/home_page.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class BottomNavigationCustom extends StatelessWidget {
  final int index;

  const BottomNavigationCustom({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralBloc, GeneralState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (state.showMenuHome) ? 1 : 0,
        child: Container(
          height: 60,
          width: 320,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38, blurRadius: 10, spreadRadius: -5)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ItemButtom(
                i: 1,
                index: index,
                iconString: 'Assets/svg/home.svg',
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: const HomePage()), (_) => false),
              ),
              _ItemButtom(
                i: 2,
                index: index,
                iconString: 'Assets/svg/favorite.svg',
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: FavoritePage()), (_) => false),
              ),
              CenterIcon(
                index: 3,
                iconString: 'Assets/svg/bolso.svg',
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: CartPage()), (_) => false),
              ),
              _ItemButtom(
                i: 4,
                index: index,
                iconString: 'Assets/svg/search.svg',
                onPressed: () {},
              ),
              _ItemProfile()
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(
          context, routeSlide(page: ProfilePage()), (_) => false),
      child: BlocBuilder<UserBloc, UserState>(
          builder: (_, state) => state.user != null
              ? state.user?.image != ''
                  ? CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(URLS.baseUrl + state.user!.image))
                  : CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorsCustom.primaryColor,
                      child: TextCustom(
                        text: state.user!.users.substring(0, 1).toUpperCase(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
              : const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsCustom.primaryColor,
                  child: CircularProgressIndicator(strokeWidth: 2))),
    );
  }
}

class CenterIcon extends StatelessWidget {
  final int index;
  final String iconString;
  final Function() onPressed;

  const CenterIcon(
      {Key? key,
      required this.index,
      required this.iconString,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: ColorsCustom.primaryColor,
        radius: 26,
        child: SvgPicture.asset(iconString,
            height: 26, color: index == 3 ? Colors.white : Colors.black87),
      ),
    );
  }
}

class _ItemButtom extends StatelessWidget {
  final int i;
  final int index;
  final String iconString;
  final Function() onPressed;

  const _ItemButtom(
      {Key? key,
      required this.i,
      required this.index,
      required this.onPressed,
      required this.iconString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
          child: SvgPicture.asset(iconString,
              height: 25,
              color: (i == index)
                  ? ColorsCustom.primaryColor
                  : Colors.black87)),
    );
  }
}
