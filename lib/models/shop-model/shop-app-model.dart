class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson((json['data'])) : null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    image = json['image'].toString();
    points = int.tryParse(json['points'].toString());
    credit = int.tryParse(json['credit'].toString());
    token = (json['token']);
  }
}
