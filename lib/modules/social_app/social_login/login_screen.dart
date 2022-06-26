import 'package:firstapp/layout/social_layout.dart';
import 'package:firstapp/modules/social_app/cubit/cubit.dart';
import 'package:firstapp/modules/social_app/social_login/login_cubit/login_cubit.dart';
import 'package:firstapp/modules/social_app/social_login/login_cubit/login_states.dart';
import 'package:firstapp/modules/social_app/social_register/social_register_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/components/push.dart';
import 'package:firstapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginError) {
            snkBar(
              context: context,
              title: state.error,
              snackColor: Colors.red,
              titleColor: Colors.white,
            );
          } else if (state is SocialLoginSuccessful) {
            SocialCubit.get(context).getUserData();
            pushAndFinish(
              context,
              const SocialLayout(),
            );
          }
        },
        builder: (context, state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);

          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            // backgroundColor: Colors.red,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 240,
                    child: SvgPicture.asset(
                      'assets/images/test.svg',
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      // height: 240,
                      // color: Colors.deepOrange,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 85,
                                      color: const Color(0xE639444C),
                                      // letterSpacing: 1.2,
                                    ),
                          ),
                          // SizedBox(height: 5,),
                          Text(
                            'Sign in to your account',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: const Color(0x7C323F48),
                                      fontSize: 19.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Container(
                            child: whiteTextForm(
                              controller: emailController,
                              validator: (value) {
                                return value!.isEmpty ? 'Required' : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              hintText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: cubit.changeEmailColor
                                    ? kRedColor
                                    : kGreyColor,
                                size: 22.5,
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  cubit.changeColor(
                                      changeColor: false, isEmail: true);
                                } else if (!cubit.changeEmailColor) {
                                  cubit.changeColor(
                                      changeColor: true, isEmail: true);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                child: whiteTextForm(
                                  controller: passwordController,
                                  prefixIcon: Icon(
                                    cubit.showPassword
                                        ? Icons.lock_open_outlined
                                        : Icons.lock_outline,
                                    color: cubit.changePassColor
                                        ? kRedColor
                                        : kGreyColor,
                                    size: 22.5,
                                  ),
                                  hintText: 'Password',
                                  inputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  obscureText: !cubit.showPassword,
                                  suffix: Text(
                                    cubit.passwordShowHide,
                                    style: const TextStyle(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  validator: (value) {
                                    return (value!.isEmpty)
                                        ? 'Required'
                                        : (value.length <= 3)
                                            ? 'Password is too short'
                                            : null;
                                  },
                                  onChanged: (value) {
                                    if (passwordController.text.isEmpty) {
                                      cubit.changeColor(
                                          changeColor: false, isEmail: false);
                                    } else if (!cubit.changePassColor) {
                                      cubit.changeColor(
                                          changeColor: true, isEmail: false);
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    cubit.hidePassword();
                                    if (formKey.currentState!.validate()) {
                                      // cubit.signIn(
                                      //   email: emailController.text,
                                      //   password: passwordController.text,
                                      // );
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 2.5,
                                  top: 3.0,
                                ),
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: () {
                                    cubit.changeShowPassword();
                                  },
                                  color: kRedColor.withAlpha(19),
                                  highlightColor: kRedColor.withAlpha(5),
                                  splashColor: kRedColor.withAlpha(25),
                                  padding: const EdgeInsets.all(0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                  elevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 53.5,
                                    decoration: const BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      cubit.passwordShowHide,
                                      style: const TextStyle(
                                        color: kRedColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                padding: const EdgeInsets.all(0),
                                shape: const StadiumBorder(),
                                highlightElevation: 5,
                                highlightColor: kRedColor.withAlpha(50),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        (state is! SocialLoginLoading)
                                            ? const Color(0XFFFF4AA3)
                                            : const Color(0XFFFF4AA3)
                                                .withAlpha(90),
                                        (state is! SocialLoginLoading)
                                            ? const Color(0XFFF8B556)
                                            : const Color(0XFFF8B556)
                                                .withAlpha(90),
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 50,
                                    ),
                                    child: (state is! SocialLoginLoading)
                                        ? Text(
                                            'SIGN IN',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 19.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.4),
                                            child: SizedBox(
                                              height: 23,
                                              width: 23,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3.5,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: kGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 2.5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SocialRegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Create',
                                  style: TextStyle(
                                    // color: Colors.grey[600],
                                    color: kRedColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
          );
        },
      ),
    );
  }
}
