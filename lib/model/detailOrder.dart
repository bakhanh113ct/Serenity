// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class DetailOrder {
  String? idDetailOrder;
  String? idOrder;
  String? idProduct;
  String? amount;
  String? name;
  String? price;
  DetailOrder({
    this.idDetailOrder,
    this.idOrder,
    this.idProduct,
    this.amount,
    this.name,
    this.price,
  });

  DetailOrder.fromJson(Map<String, dynamic> json) {
    idDetailOrder = json['idDetailOrder'];
    idOrder = json['idOrder'];
    idProduct = json['idProduct'];
    amount = json['amount'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDetailOrder'] = idDetailOrder;
    data['idProduct'] = idProduct;
    data['idOrder'] = idOrder;
    data['amount'] = amount;
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  DetailOrder copyWith({
    String? idDetailOrder,
    String? idOrder,
    String? idProduct,
    String? amount,
    String? name,
    String? price,
  }) {
    return DetailOrder(
      idDetailOrder: idDetailOrder ?? this.idDetailOrder,
      idOrder: idOrder ?? this.idOrder,
      idProduct: idProduct ?? this.idProduct,
      amount: amount ?? this.amount,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
