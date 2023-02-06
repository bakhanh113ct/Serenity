import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';
import 'package:serenity/widget/warehouseWidget/receipt_document_moreButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/receipt_document.dart';



class ReceiptDocumentDataSource extends DataGridSource {
  var phone = '';
  final BuildContext context;
  List<DataGridRow> _receiptDocuments = [];
  List<ReceiptDocument> allReceiptDocuments = [];
  int newRowsPerPage = 1;
  ReceiptDocumentDataSource(
      {required List<ReceiptDocument> receiptDocuments, required this.context}) {
    if (receiptDocuments.isEmpty) return;
    allReceiptDocuments = receiptDocuments;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _receiptDocuments;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        child: dataGridCell.columnName == 'more'
            ? ReceiptDocumentMoreButton(receiptDocument: dataGridCell.value,)
            : Text(dataGridCell.value.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _receiptDocuments = allReceiptDocuments
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'no', value: i++),
              DataGridCell<String>(columnName: 'nameSupplier', value: e.nameSupplier),
              DataGridCell<int>(columnName: 'amount', value: e.listProducts!.length),
              DataGridCell<String>(
                  columnName: 'totalPrice',
                  value: e.totalMoney!),
              DataGridCell<String>(
                  columnName: 'dateCreated',
                  value:
                      DateFormat('dd-MM-yyyy').format(e.dateCreated!.toDate())),
              DataGridCell<ReceiptDocument>(columnName: 'more', value: e),
            ]))
        .toList(growable: false);
  }
}
