// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:serenity/model/product_import_order.dart';

class ReceiptDocument {
  String? idReceiptDocument;
  String? nameSupplier;
  String? idImportOrder;
  String? idStaff;
  Timestamp? dateCreated;
  List<ProductImportOrder>? listProducts;
  String? signStaff;
  String? totalMoney;
  ReceiptDocument({
    this.idReceiptDocument,
    this.idImportOrder,
    this.idStaff,
    this.nameSupplier,
    this.dateCreated,
    this.listProducts,
    this.signStaff,
    this.totalMoney,
  });

  ReceiptDocument.fromJson(Map<String, dynamic> json) {
    idReceiptDocument = json['idReceiptDocument'];
    idImportOrder = json['idImportOrder'];
    idStaff = json['idStaff'];
    nameSupplier = json['nameSupplier'];
    dateCreated = json['dateCreated'];
   if (json['listProduct'] != null) {
      listProducts = <ProductImportOrder>[];
      json['listProduct'].forEach((v) {
        listProducts!.add(ProductImportOrder.fromJson(v));
      });
    }
    signStaff = json['signStaff'];
    totalMoney = json['totalMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idReceiptDocument'] = idReceiptDocument;
    data['idImportOrder'] = idImportOrder;
    data['idStaff'] = idStaff;
    data['nameSupplier'] = nameSupplier;
   if (listProducts != null) {
      data['listProduct'] = listProducts!.map((v) => v.toJson()).toList();
    }
    data['dateCreated'] = dateCreated;
    data['signStaff'] = signStaff;
    data['totalMoney'] = totalMoney;
    return data;
  }

  ReceiptDocument copyWith({
    String? idReceiptDocument,
    String? nameSupplier,
    String? idImportOrder,
    String? idStaff,
    Timestamp? dateCreated,
    List<ProductImportOrder>? listProducts,
    String? signStaff,
    String? totalMoney,
  }) {
    return ReceiptDocument(
      idReceiptDocument: idReceiptDocument ?? this.idReceiptDocument,
      nameSupplier: nameSupplier ?? this.nameSupplier,
      idImportOrder: idImportOrder ?? this.idImportOrder,
      idStaff: idStaff ?? this.idStaff,
      dateCreated: dateCreated ?? this.dateCreated,
      listProducts: listProducts ?? this.listProducts,
      signStaff: signStaff ?? this.signStaff,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}
