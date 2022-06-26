import 'package:firstapp/models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopLoadingChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{}
class ShopErrorUpdateUserState extends ShopStates{}
