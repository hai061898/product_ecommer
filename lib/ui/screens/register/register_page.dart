import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:product_ecommer/bloc/user/user_bloc.dart';
import 'package:product_ecommer/ui/helpers/animation_route.dart';
import 'package:product_ecommer/ui/helpers/validation_form.dart';
import 'package:product_ecommer/ui/modals/error_message.dart';
import 'package:product_ecommer/ui/modals/modal_loading.dart';
import 'package:product_ecommer/ui/modals/modal_success.dart';
import 'package:product_ecommer/ui/screens/login/login_page.dart';
import 'package:product_ecommer/ui/themes/color_c.dart';
import 'package:product_ecommer/ui/widgets/btn_c.dart';
import 'package:product_ecommer/ui/widgets/text_c.dart';
import 'package:product_ecommer/ui/widgets/text_field_frave.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passowrdController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = TextEditingController();
    emailController = TextEditingController();
    passowrdController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    userController.dispose();
    emailController.dispose();
    passowrdController.dispose();
    passController.dispose();
    super.dispose();
  }

  void clear() {
    userController.clear();
    emailController.clear();
    passowrdController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Validating...');
        }
        if (state is SuccessUserState) {
          Navigator.of(context).pop();
          modalSuccess(context, 'USER CREATED', onPressed: () {
            clear();
            Navigator.pushReplacement(context, routeSlide(page: SignInPage()));
          });
        }
        if (state is FailureUserState) {
          Navigator.of(context).pop();
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              child: const TextCustom(
                  text: 'Log In',
                  fontSize: 17,
                  color: ColorsCustom.primaryColor),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('signInPage'),
            ),
            const SizedBox(width: 5)
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            children: [
              const TextCustom(
                  text: 'Welcome to Frave Shop',
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
              const SizedBox(height: 5.0),
              const TextCustom(text: 'Create Account', fontSize: 17),
              const SizedBox(height: 20.0),
              TextFormCustom(
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
                controller: userController,
                validator: RequiredValidator(errorText: 'Username is required'),
              ),
              const SizedBox(height: 15.0),
              TextFormCustom(
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  controller: emailController,
                  validator: validatedEmail),
              const SizedBox(height: 15.0),
              TextFormCustom(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.vpn_key_rounded),
                isPassword: true,
                controller: passowrdController,
                validator: passwordValidator,
              ),
              const SizedBox(height: 15.0),
              TextFormCustom(
                  hintText: 'Repeat Password',
                  controller: passController,
                  prefixIcon: const Icon(Icons.vpn_key_rounded),
                  isPassword: true,
                  validator: (val) =>
                      MatchValidator(errorText: 'Password do not macth ')
                          .validateMatch(val!, passowrdController.text)),
              const SizedBox(height: 25.0),
              Row(
                children: const [
                  Icon(Icons.check_circle_rounded, color: Color(0xff0C6CF2)),
                  TextCustom(
                    text: ' I Agree to Frave Shop ',
                    fontSize: 15,
                  ),
                  TextCustom(
                      text: ' Terms of Use',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0C6CF2)),
                ],
              ),
              const SizedBox(height: 25.0),
              BtnCustom(
                text: 'Sign Up',
                width: size.width,
                fontSize: 20,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    userBloc.add(OnAddNewUser(
                        userController.text.trim(),
                        emailController.text.trim(),
                        passowrdController.text.trim()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
