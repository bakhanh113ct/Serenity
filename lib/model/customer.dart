// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? idCustomer;
  String? name;
  Timestamp? dateOfBirth;
  String? email;
  String? address;
  String? image;
  String? phone;
  String? purchased;

  Customer( 
      {this.idCustomer,
      this.name,
      this.dateOfBirth,
      this.email,
      this.address,
      this.image,
      this.phone,
      this.purchased = '0'});

  Customer.fromJson(Map<String, dynamic> json) {
    idCustomer = json['idCustomer'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
    phone = json['phone'];
    purchased = json['purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCustomer'] = idCustomer;
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['email'] = email;
    data['address'] = address;
    data['image'] = image;
    data['phone'] = phone;
    data['purchased'] = purchased;
    return data;
  }
  

  Customer copyWith({
    String? idCustomer,
    String? name,
    Timestamp? dateOfBirth,
    String? email,
    String? address,
    String? image,
    String? phone,
    String? purchased,
  }) {
    return Customer(
      idCustomer: idCustomer ??  this.idCustomer,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      address: address ?? this.address,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      purchased: purchased ?? this.purchased,
    );
  }
}
