import 'dart:developer';

import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/modules/shop_app/register/register_cubit/register_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) {
    return BlocProvider.of(context);
  }

  bool showPassword = false;
  String passwordShowHide = 'Show';
  bool changePassColor = false;
  bool changeEmailColor = false;


  void changePasswordVisibility () {
    showPassword = !showPassword;
    passwordShowHide = showPassword ? 'Hide' : 'Show';
    emit(ShopRegisterChangePasswordVisibility());
  }


  void hidePassword () {
    showPassword = false;
    passwordShowHide = 'Show';
    emit(ShopRegisterChangePasswordVisibility());
  }

  void changeColor({
    required bool changeColor,
    required bool isEmail,
  }) {
    isEmail ? changeEmailColor = changeColor : changePassColor = changeColor;
    emit(ShopRegisterChangeColor());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String lang = 'ar',
  }) {
    // loading
    emit(ShopRegisterLoading());

    // post login data
    DioHelper.postData(
      endPoint: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
      lang: lang,
    ).then((value) {
      emit(ShopRegisterSuccessful(ShopLoginModel(value.data)));
    }).catchError((error) {
      log('-- Error when Register: ${error.toString()}');
      emit(ShopRegisterError());
    });
  }
}
