class CategoriesModel
{
  bool? status;
  String message ='';
  DataCategoriesModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? DataCategoriesModel.fromJson(json['data']) : null ;

  }
}


class DataCategoriesModel
{
  int? currentPage;
  List<DataModel> data = [];

  DataCategoriesModel.fromJson(Map<String , dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element,),);
    });

  }
}


class DataModel
{
  int? id;
  String name = '';
  String image = '';

  DataModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    image = json['image'];

  }
}