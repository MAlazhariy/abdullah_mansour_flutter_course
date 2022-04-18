import 'dart:developer';

import 'package:firstapp/models/shop_app/categories_model.dart';
import 'package:firstapp/models/shop_app/change_favorites_model.dart';
import 'package:firstapp/models/shop_app/get_favorites_model.dart';
import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/models/shop_app/login_model.dart';
import 'package:firstapp/modules/shop_app/categories/categories_screen.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/modules/shop_app/favorites/favorites_screen.dart';
import 'package:firstapp/modules/shop_app/products/products_screen.dart';
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
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool> favorites = {};
  GetFavoritesModel? favoritesModel;
  ShopLoginModel? userModel;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getDate(
      endPoint: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      log('error when getHomeData: ' + error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    DioHelper.getDate(
      endPoint: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      log('error when getCategoriesData: ' + error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId) {

    favorites.update(productId, (value) => !value);
    emit(ShopLoadingChangeFavoritesState());

    DioHelper.postData(
      endPoint: FAVORITES,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if(changeFavoritesModel!.status == false){
        favorites.update(productId, (value) => !value);
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      log('error when changeFavorites: ' + error.toString());
      favorites.update(productId, (value) => !value);
      emit(ShopErrorChangeFavoritesState());
    });
  }

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    log('loading ShopLoadingGetFavoritesState');

    DioHelper.getDate(
      endPoint: FAVORITES,
    ).then((value) {
      favoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getDate(
      endPoint: PROFILE,
    ).then((value) {
      userModel = ShopLoginModel(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      log('error when getUserData: ' + error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}
