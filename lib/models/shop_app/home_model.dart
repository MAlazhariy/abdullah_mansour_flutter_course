class HomeModel {
  late final bool status;
  late final HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  late final List<BannerModel> banners = [];
  late final List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> data) {

    data['banners'].forEach((element) {
      banners.add(
        BannerModel.fromJson(element),
      );
    });

    data['products'].forEach((element) {
      products.add(
        ProductModel.fromJson(element),
      );
    });

  }
}

class BannerModel {
  late final int id;
  late final String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late final int id;

  late final double price;
  late final double oldPrice;
  late final double discount;

  late final String image;
  late final String name;

  late final bool inFavorites;
  late final bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'].toDouble();
    oldPrice = json['old_price'].toDouble();
    discount = json['discount'].toDouble();

    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
