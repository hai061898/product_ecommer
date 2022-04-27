import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_ecommer/bloc/product/product_bloc.dart';
import 'package:product_ecommer/bloc/user/user_bloc.dart';
import 'package:product_ecommer/data/services/url.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/screens/cart/cart_page.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) => state.user != null
                    ? Row(
                        children: [
                          state.user!.image != ''
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      URLS.baseUrl + state.user!.image),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorsCustom.primaryColor,
                                  child: TextCustom(
                                    text: state.user!.users
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                          const SizedBox(width: 5.0),
                          TextCustom(
                            text: state.user!.users,
                            fontSize: 18,
                          )
                        ],
                      )
                    : const SizedBox()),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => Navigator.of(context)
                .pushAndRemoveUntil(routeSlide(page: const CartPage()), (_) => false),
            child: Stack(
              children: [
                FadeInRight(
                    child: SizedBox(
                        height: 32,
                        width: 32,
                        child: SvgPicture.asset('Assets/bolso-negro.svg',
                            height: 25))),
                Positioned(
                  left: 0,
                  top: 12,
                  child: FadeInDown(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                          color: ColorsCustom.primaryColor,
                          shape: BoxShape.circle),
                      child: Center(
                          child: BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) => state.amount == 0
                                  ? const TextCustom(
                                      text: '0',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)
                                  : TextCustom(
                                      text: '${state.products!.length}',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
