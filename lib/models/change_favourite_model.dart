class FavouriteModel {
  bool? status;
  String? message;

  FavouriteModel({this.status, this.message});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}