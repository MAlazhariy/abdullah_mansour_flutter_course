
class SearchModel {
  late bool status;
  String? message;
  late SearchDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  List<SearchProductModel> data = [];
  late int total;

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    json['data'].forEach((element) {
      data.add(
        SearchProductModel.fromJson(element),
      );
    });
  }
}

class SearchProductModel {
  late int id;
  late double price;

  late final List images;
  late final String name;
  late final String description;

  late final bool inFavorites;

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'].toDouble();

    images = json['images'];
    name = json['name'];
    description = json['description'];

    inFavorites = json['in_favorites'];
  }
}
