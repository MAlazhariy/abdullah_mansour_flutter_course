import 'package:firstapp/layout/shop_layout.dart';
import 'package:firstapp/modules/shop_app/login/login_screen.dart';
import 'package:firstapp/modules/shop_app/register/register_cubit/register_cubit.dart';
import 'package:firstapp/modules/shop_app/register/register_cubit/register_states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppRegisterScreen extends StatelessWidget {
  ShopAppRegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessful) {
            if (state.loginInfo.status == true) {
              snkBar(
                context: context,
                title: state.loginInfo.message ?? 'NULL',
                seconds: 3,
                snackColor: Colors.green,
                // titleColor: Colors.white,
              );

              CacheHelper.setToken(state.loginInfo.data!.token);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ShopLayout();
                }),
                    (route) => false,
              );
            } else {
              snkBar(
                context: context,
                title: state.loginInfo.message ?? 'NULL exception',
                seconds: 5,
                snackColor: Colors.red,
                titleColor: Colors.white,
              );
            }
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);

          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            // backgroundColor: Colors.red,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   height: 80,
                  //   child: SvgPicture.asset(
                  //     'assets/images/test.svg',
                  //     fit: BoxFit.cover,
                  //     alignment: Alignment.bottomCenter,
                  //     // height: 240,
                  //     // color: Colors.deepOrange,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 60,
                                      color: const Color(0xE639444C),
                                      // letterSpacing: 1.2,
                                    ),
                          ),
                          // SizedBox(height: 5,),
                          Text(
                            'Create a new account',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: const Color(0x7C323F48),
                                      fontSize: 19.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(height: 45),

                          // name
                          Container(
                            child: whiteTextForm(
                              controller: nameController,
                              validator: (value) {
                                return value!.isEmpty ? 'Required' : null;
                              },
                              keyboardType: TextInputType.name,
                              inputAction: TextInputAction.next,
                              hintText: 'User name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: cubit.changeEmailColor
                                    ? kRedColor
                                    : kGreyColor,
                                size: 22.5,
                              ),
                              // onChanged: (value) {
                              //   if (value.isEmpty) {
                              //     cubit.changeColor(
                              //         changeColor: false, isEmail: true);
                              //   } else if (!cubit.changeEmailColor) {
                              //     cubit.changeColor(
                              //         changeColor: true, isEmail: true);
                              //   }
                              // },
                            ),
                          ),
                          const SizedBox(height: 8),

                          // email
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
                          const SizedBox(height: 8),

                          // password
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
                                  inputAction: TextInputAction.next,
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
                                    // if (formKey.currentState!.validate()) {
                                    //   cubit.register(
                                    //     email: emailController.text,
                                    //     password: passwordController.text,
                                    //     name: nameController.text,
                                    //     phone: phoneController.text,
                                    //   );
                                    // }
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
                                    cubit.changePasswordVisibility();
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
                          const SizedBox(height: 8),

                          // phone
                          Container(
                            child: whiteTextForm(
                              controller: phoneController,
                              validator: (value) {
                                return value!.isEmpty ? 'Required' : null;
                              },
                              keyboardType: TextInputType.phone,
                              inputAction: TextInputAction.done,
                              hintText: 'Phone number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: cubit.changeEmailColor
                                    ? kRedColor
                                    : kGreyColor,
                                size: 22.5,
                              ),
                              // onChanged: (value) {
                              //   if (value.isEmpty) {
                              //     cubit.changeColor(
                              //         changeColor: false, isEmail: true);
                              //   } else if (!cubit.changeEmailColor) {
                              //     cubit.changeColor(
                              //         changeColor: true, isEmail: true);
                              //   }
                              // },
                            ),
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
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
                                        (state is! ShopRegisterLoading)
                                            ? const Color(0XFFFF4AA3)
                                            : const Color(0XFFFF4AA3)
                                                .withAlpha(90),
                                        (state is! ShopRegisterLoading)
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
                                    child: (state is! ShopRegisterLoading)
                                        ? Text(
                                            'REGISTER',
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
                                'Have an account?',
                                style: TextStyle(
                                  color: kGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 3),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShopAppLoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
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
