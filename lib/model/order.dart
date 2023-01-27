// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['idCustomer'] = idCustomer;
    data['idUser'] = idUser;
    data['idOrder'] = idOrder;
    data['idVoucher'] = idVoucher;
    data['nameCustomer'] = nameCustomer;
    data['price'] = price;
    data['profit'] = profit;
    data['status'] = status;
    return data;
  }

  MyOrder copyWith({
    Timestamp? dateCreated,
    String? idCustomer,
    String? idUser,
    String? idOrder,
    String? idVoucher,
    String? nameCustomer,
    String? price,
    String? profit,
    String? status,
  }) {
    return MyOrder(
      dateCreated: dateCreated ?? this.dateCreated,
      idCustomer: idCustomer ?? this.idCustomer,
      idUser: idUser ?? this.idUser,
      idOrder: idOrder ?? this.idOrder,
      idVoucher: idVoucher ?? this.idVoucher,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      price: price ?? this.price,
      profit: profit ?? this.profit,
      status: status ?? this.status,
    );
  }
}
