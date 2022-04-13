import 'package:firstapp/modules/shop_app/create_account.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bot_toast/bot_toast.dart';

class ShopAppLoginScreen extends StatelessWidget {
  ShopAppLoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return BlocProvider(
      create: (context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if (state is ShopAppLoginSuccessful) {
            if (state.loginInfo.status == true) {
              BotToast.showText(
                text: state.loginInfo.message,
                duration: const Duration(seconds: 6),
                contentColor: Colors.greenAccent,
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(50),
              );
            }
            else {
              // Fluttertoast.showToast(
              //     msg: state.loginInfo.message,
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.white,
              //     textColor: Colors.black54,
              //     // fontSize: 30,
              // );

              BotToast.showText(
                text: state.loginInfo.message,
                duration: const Duration(seconds: 6),
                contentColor: Colors.redAccent,
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(50),
              );
            }
          }
        },
        builder: (context, state) {
          ShopAppCubit cubit = ShopAppCubit.get(context);
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 85,
                              color: const Color(0xE639444C),
                              // letterSpacing: 1.2,
                            ),
                          ),
                          // SizedBox(height: 5,),
                          Text(
                            'Sign in to your account',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                              color: const Color(0x7C323F48),
                              fontSize: 19.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 45,),
                          Container(
                            child: whiteTextForm(
                              controller: emailController,
                              validator: (value) {
                                return value!.isEmpty
                                    ? 'Required'
                                    : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              hintText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: cubit.changeEmailColor
                                    ? redColor
                                    : greyColor,
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
                          const SizedBox(height: 25,),
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
                                        ? redColor
                                        : greyColor,
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
                                      cubit.signIn(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        lang: 'ar',
                                      );
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
                                  color: redColor.withAlpha(19),
                                  highlightColor: redColor.withAlpha(5),
                                  splashColor: redColor.withAlpha(25),
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
                                      style: TextStyle(
                                        color: redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40,),
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
                                highlightColor: redColor.withAlpha(50),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        (state is! ShopAppLoginLoading)
                                            ? const Color(0XFFFF4AA3)
                                            : const Color(0XFFFF4AA3).withAlpha(
                                            90),
                                        (state is! ShopAppLoginLoading)
                                            ? const Color(0XFFF8B556)
                                            : const Color(0XFFF8B556).withAlpha(
                                            90),
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
                                    child: (state is! ShopAppLoginLoading)
                                        ? Text(
                                      'SIGN IN',
                                      style: Theme
                                          .of(context)
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
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: greyColor,
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
                                      builder: (
                                          context) => const CreateAccount(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    // color: Colors.grey[600],
                                    color: redColor,
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
