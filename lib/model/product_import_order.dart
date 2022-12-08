import 'package:equatable/equatable.dart';
import 'package:serenity/model/product.dart';

class ProductImportOrder extends Equatable {
  int? amount;
  String? note;
  Product? product;

  ProductImportOrder({this.amount, this.note, this.product});

  ProductImportOrder.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    note = json['note'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['amount'] = this.amount;
    data['note'] = this.note;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        amount,
        note,
        product,
      ];
}
