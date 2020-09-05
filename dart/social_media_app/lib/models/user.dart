import 'package:social_media_app/models/address.dart';

class User {
  int id;
  String name;
  String username;
  String email;
  Address address;

  // address
  String phone;
  String website;

  //company
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        address = Address.fromJson(json['address']),
        phone = json['phone'],
        website = json['website'];
}
