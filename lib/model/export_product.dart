// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ExportProduct extends Equatable {
  String? amount;
  String? category;
  String? content;
  String? idExportProduct;
  String? image;
  String? name;
  String? price;
  String? historicalCost;
  String? idOrder;
  Timestamp? dateExport;
  ExportProduct({
    this.amount,
    this.category,
    this.content,
    this.idExportProduct,
    this.image,
    this.name,
    this.price,
    this.historicalCost,
    this.idOrder,
    this.dateExport,
  });

  ExportProduct.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    category = json['category'];
    content = json['content'];
    dateExport = json['dateExport'];
    idOrder = json['idOrder'];
    idExportProduct = json['idExportProduct'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    historicalCost = json['historicalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['category'] = category;
    data['content'] = content;
    data['idExportProduct'] = idExportProduct;
    data['image'] = image;
    data['dateExport'] = dateExport;
    data['idOrder'] = idOrder;
    data['name'] = name;
    data['price'] = price;
    data['historicalCost'] = historicalCost;
    return data;
  }

  @override
  // List<Object?> get props => [name,price,idExportProduct];
  List<Object?> get props => [
        name,
        price,
        idExportProduct,
        amount,
        category,
        content,
        image,
        historicalCost,
        dateExport,
        idOrder,
      ];

  ExportProduct copyWith({
    String? amount,
    String? category,
    String? content,
    String? idExportProduct,
    String? image,
    String? name,
    String? price,
    String? historicalCost,
    Timestamp? dateExport,
    String? idOrder,
  }) {
    return ExportProduct(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      content: content ?? this.content,
      idExportProduct: idExportProduct ?? this.idExportProduct,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      dateExport: dateExport ?? this.dateExport,
      idOrder: idOrder ?? this.idOrder,
      historicalCost: historicalCost ?? this.historicalCost,
    );
  }
}
