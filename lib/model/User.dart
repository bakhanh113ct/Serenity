import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? idUser;
  String? fullName;
  String? phone;
  String? email;
  Timestamp? dateOfBirth;
  int? salary;
  String? image;
  String? position;
  String? address;

  User(
      {this.idUser,
      this.fullName,
      this.phone,
      this.email,
      this.dateOfBirth,
      this.salary,
      this.image,
      this.position,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    salary = json['salary'];
    image = json['image'];
    position = json['position'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['salary'] = this.salary;
    data['image'] = this.image;
    data['position'] = this.position;
    data['address'] = this.address;
    return data;
  }
}