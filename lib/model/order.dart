import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrder {
  Timestamp? dateCreated;
  String? idCustomer;
  String? idUser;
  String? idOrder;
  String? idVoucher;
  String? nameCustomer;
  String? price;
  String? profit;
  String? status;

  MyOrder(
      {this.dateCreated,
      this.idCustomer,
      this.idUser,
      this.idOrder,
      this.idVoucher,
      this.nameCustomer,
      this.price,
      this.profit,
      this.status});

  MyOrder.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    idCustomer = json['idCustomer'];
    idUser = json['idUser'];
    idOrder = json['idOrder'];
    idVoucher = json['idVoucher'];
    nameCustomer = json['nameCustomer'];
    price = json['price'];
    profit = json['profit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCreated'] = this.dateCreated;
    data['idCustomer'] = this.idCustomer;
    data['idUser'] = this.idUser;
    data['idOrder'] = this.idOrder;
    data['idVoucher'] = this.idVoucher;
    data['nameCustomer'] = this.nameCustomer;
    data['price'] = this.price;
    data['profit'] = this.profit;
    data['status'] = this.status;
    return data;
  }
}