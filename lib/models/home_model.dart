class HomeModel
{
  bool? status;
  String message ='';
  DataHomeModel? data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? DataHomeModel.fromJson(json['data']) : null ;
  }

}

class DataHomeModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  DataHomeModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel
{
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  dynamic image;
  bool? inFavorites;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    inCart = json['in_cart'];
    image = json['image'];
    inFavorites = json['in_favorites'];

  }
}