class CategoriesModel {
  bool status;
  CategoriesIsDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesIsDataModel.fromJson(json['data']);
  }
}

class CategoriesIsDataModel {
  int currentPage;

  List<DataModel> data = [];

  CategoriesIsDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int id;
  String name;
  String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'].toString();
    image = json['image'].toString();
  }
}
