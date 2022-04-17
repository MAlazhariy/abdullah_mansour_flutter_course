
class GetFavoritesModel {
  late bool status;
  String? message;
  late GetFavoritesDataModel data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GetFavoritesDataModel.fromJson(json['data']);
  }
}

class GetFavoritesDataModel {
  List<FavoritesDataModel> data = [];
  late int total;

  GetFavoritesDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    json['data'].forEach((element) {
      data.add(
        FavoritesDataModel.fromJson(element),
      );
    });
  }
}

class FavoritesDataModel {
  late int id;
  late FavoritesProductModel product;

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoritesProductModel.fromJson(json['product']);
  }
}

class FavoritesProductModel {
  late int id;
  late double price;
  late double oldPrice;
  late final double discount;

  late final String image;
  late final String name;
  late final String description;

  FavoritesProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'].toDouble();
    oldPrice = json['old_price'].toDouble();
    discount = json['discount'].toDouble();

    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
