class ShopRegisterModel {
  bool? status;
  dynamic message;
  RegisterData? data;

  ShopRegisterModel({this.status, this.message, this.data});

  ShopRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  RegisterData.fromJson(json['data']) : null;
  }
}

class RegisterData {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;


  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
