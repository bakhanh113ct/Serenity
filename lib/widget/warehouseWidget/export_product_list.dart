import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';

import '../../model/detail_order.dart';
import '../../model/product.dart';

class ExportProductList extends StatelessWidget {
  const ExportProductList({required this.list, super.key});
  final List<DetailOrder> list;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((e) {
        return FutureBuilder(
            future: getProduct(e.idProduct!, e),
            builder: (BuildContext context, AsyncSnapshot<Product> pro) {
              if (!pro.hasData) {
                return const Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()));
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ListTile(
                    trailing: Text(double.parse(e.price!).toInt().toString().toVND(), style: Theme.of(context).textTheme.headline2,),
                    title: Text('${e.name}'),
                    subtitle: Text(
                        'Amount: ${e.amount!}x \n ${pro.data!.content}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pro.data!.image!),
                    ),
                  ),
                );
              } 
            });
      }).toList(),
    );
  }
  Future<Product> getProduct(String idProduct, DetailOrder dt) async {
    var pro = await ImportBookRepository().getProductImportBook(idProduct);
    return pro;
  }
}
