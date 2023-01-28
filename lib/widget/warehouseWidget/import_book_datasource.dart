
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:serenity/widget/warehouseWidget/import_book_moreButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/product.dart';


class ImportBookDataSource extends DataGridSource {
  BuildContext? context;

  /// Creates the employee data source class with required details.
  ImportBookDataSource(
      {required List<Product> importBookData,
      required BuildContext this.context}) {
     int i = 1;
    _importBook = importBookData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'STT', value: (i++).toString()),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'price', value: e.price.toVND()),
              DataGridCell<String>(columnName: 'amount', value: e.amount!),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(columnName: 'content', value: e.content),
              DataGridCell<Product>(columnName: 'more', value: e),
            ]))
        .toList();
  }

  List<DataGridRow> _importBook = [];

  @override
  List<DataGridRow> get rows => _importBook;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
          alignment: Alignment.center,
          child: e.columnName == 'more'
              ? ImportBookMoreButton(importBook: e.value)
                      :  Text(e.value.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }
}

