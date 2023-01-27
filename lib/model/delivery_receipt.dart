// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/model/product.dart';

class DeliveryReceipt {
  String? idDeliveryReceipt;
  String? nameCustomer;
  String? idOrder;
  String? idStaff;
  Timestamp? dateCreated;
  List<Product>? listProducts;
  String? signStaff;
  String? totalMoney;
  DeliveryReceipt({
    this.idDeliveryReceipt,
    this.nameCustomer,
    this.idStaff,
    this.idOrder,
    this.dateCreated,
    this.listProducts,
    this.signStaff,
    this.totalMoney,
  });

  DeliveryReceipt.fromJson(Map<String, dynamic> json) {
    idDeliveryReceipt = json['idDeliveryReceipt'];
    idOrder = json['idOrder'];
    idStaff = json['idStaff'];
    nameCustomer = json['nameCustomer'];
    dateCreated = json['dateCreated'];
    if (json['listProducts'] != null) {
      listProducts = <Product>[];
      json['listProducts'].forEach((v) {
        listProducts!.add(Product.fromJson(v));
      });
    }
    signStaff = json['signStaff'];
    totalMoney = json['totalMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDeliveryReceipt'] = idDeliveryReceipt;
    data['idOrder'] = idOrder;
    data['idStaff'] = idStaff;
    data['nameCustomer'] = nameCustomer;
    if (listProducts != null) {
      data['listProducts'] = listProducts!.map((v) => v.toJson()).toList();
    }
    data['dateCreated'] = dateCreated;
    data['signStaff'] = signStaff;
    data['totalMoney'] = totalMoney;
    return data;
  }

  DeliveryReceipt copyWith({
    String? idDeliveryReceipt,
    String? nameCustomer,
    String? idOrder,
    String? idStaff,
    Timestamp? dateCreated,
    List<Product>? listProducts,
    String? signStaff,
    String? totalMoney,
  }) {
    return DeliveryReceipt(
      idDeliveryReceipt: idDeliveryReceipt ?? this.idDeliveryReceipt,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      idOrder: idOrder ?? this.idOrder,
      idStaff: idStaff ?? this.idStaff,
      dateCreated: dateCreated ?? this.dateCreated,
      listProducts: listProducts ?? this.listProducts,
      signStaff: signStaff ?? this.signStaff,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}
