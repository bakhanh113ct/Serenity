import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../model/export_product.dart';
import 'export_book_moreButton.dart';

class ExportBookDataSource extends DataGridSource {
  var phone = '';
  final BuildContext context;
  List<DataGridRow> _exportProducts = [];
  List<ExportProduct> allExportProducts = [];
  int newRowsPerPage = 1;
  ExportBookDataSource(
      {required List<ExportProduct> exportProducts,
      required this.context}) {
    if (exportProducts.isEmpty) return;
    allExportProducts = exportProducts;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _exportProducts;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.columnName == 'more'
            ? Center(
                child: ExportBookMoreButton(
                exportBook: dataGridCell.value,
              ))
            : Center(
                child: Text(dataGridCell.value.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis),
              ),
      );
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _exportProducts = allExportProducts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'STT', value: (i++).toString()),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'price', value: e.price.toVND()),
              DataGridCell<String>(columnName: 'amount', value: e.amount!),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(columnName: 'dateExport', value: DateFormat('dd-MM-yyy').format(e.dateExport!.toDate())),
              DataGridCell<ExportProduct>(columnName: 'more', value: e),
            ]))
        .toList(growable: false);
  }
}
