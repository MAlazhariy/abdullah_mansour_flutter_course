import 'dart:developer';

import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/modules/shop_app/categories/categories_screen.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/modules/shop_app/favorites/favorites_screen.dart';
import 'package:firstapp/modules/shop_app/products/product_screen.dart';
import 'package:firstapp/modules/shop_app/settings/settings_screen.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    HomeModel? homeModel;

    DioHelper.getDate(url: HOME).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      log(homeModel.toString());

      emit(ShopSuccessHomeDataState());

    }).catchError((error) {
      log(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
