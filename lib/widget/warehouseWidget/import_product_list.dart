import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:serenity/model/product_import_order.dart';

class ImportProductList extends StatelessWidget {
  const ImportProductList({ required this.list,super.key});
  final List<ProductImportOrder> list;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((e) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListTile(
            trailing: Text('${e.amount!} x'),
            title: Text(e.product!.name!),
            subtitle: Text('${e.product!.category!} \n${e.product!.price!.toVND(unit: 'đ')}'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(e.product!.image!),
            )),
          
        );
    }).toList(),
    );
  }
}