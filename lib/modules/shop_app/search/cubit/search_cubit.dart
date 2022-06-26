import 'dart:developer';

import 'package:firstapp/models/shop_app/search_model.dart';
import 'package:firstapp/modules/shop_app/search/cubit/search_states.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  Map<int, bool> favorites = {};
  // ChangeFavoritesModel? changeFavoritesModel;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      endPoint: SEARCH,
      token: CacheHelper.getToken(),
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      log('error when search: ' + error.toString());
      emit(SearchErrorState());
    });
  }

  // void changeFavorites(int productId) {
  //
  //   favorites.update(productId, (value) => !value);
  //   emit(SearchLoadingChangeFavoritesState());
  //
  //   DioHelper.postData(
  //     endPoint: FAVORITES,
  //     data: {
  //       'product_id': productId,
  //     },
  //   ).then((value) {
  //     changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  //
  //     if(changeFavoritesModel!.status == false){
  //       favorites.update(productId, (value) => !value);
  //     }
  //     emit(SearchSuccessChangeFavoritesState());
  //   }).catchError((error) {
  //     log('error when changeFavorites in search: ' + error.toString());
  //     favorites.update(productId, (value) => !value);
  //     emit(SearchErrorChangeFavoritesState());
  //   });
  // }
}
