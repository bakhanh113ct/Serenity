import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Customer extends Equatable{
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
      this.purchased});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCustomer'] = this.idCustomer;
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['address'] = this.address;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['purchased'] = this.purchased;
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [name,phone,idCustomer];
}