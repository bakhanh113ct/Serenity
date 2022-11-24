// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String imageUrl;
  final String dateOfBirth;
  double? purchased;

  Customer({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.imageUrl,
    this.purchased, 
    required this.dateOfBirth,
  }) {
    purchased = 0;
  }

  Customer copyWith({
    String? id,
    String? name,
    String? address,
    String? email,
    String? phone,
    String? imageUrl,
    String? dateOfBirth,
    double? purchased,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      purchased: purchased ?? this.purchased,
      imageUrl: imageUrl ?? this.imageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'dateOfBirth': dateOfBirth,
      'purchased': purchased,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      imageUrl: map['imageUrl'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      purchased: map['purchased'] != null ? map['purchased'] as double : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, address, email, phone, purchased, imageUrl, dateOfBirth];

}
