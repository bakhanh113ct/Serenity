import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/widget/warehouseWidget/receipt_document_moreButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/delivery_receipt.dart';
import '../../model/receipt_document.dart';
import 'delivery_receipt_moreButton.dart';

class DeliveryReceiptDataSource extends DataGridSource {
  var phone = '';
  final BuildContext context;
  List<DataGridRow> _deliveryReceipts = [];
  List<DeliveryReceipt> allDeliveryReceipts = [];
  int newRowsPerPage = 1;
  DeliveryReceiptDataSource(
      {required List<DeliveryReceipt> deliveryReceipts,
      required this.context}) {
    if (deliveryReceipts.isEmpty) return;
    allDeliveryReceipts = deliveryReceipts;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _deliveryReceipts;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: dataGridCell.columnName == 'more'
            ?  DeliveryReceiptMoreButton(
                deliveryReceipt: dataGridCell.value,
              )
            :  Text(dataGridCell.value.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _deliveryReceipts = allDeliveryReceipts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'no', value: i++),
              DataGridCell<String>(
                  columnName: 'nameCustomer', value: e.nameCustomer),
              DataGridCell<int>(
                  columnName: 'amount', value: e.listProducts!.length),
              DataGridCell<String>(
                  columnName: 'totalPrice', value: e.totalMoney!),
              DataGridCell<String>(
                  columnName: 'dateCreated',
                  value:
                      DateFormat('dd-MM-yyyy').format(e.dateCreated!.toDate())),
              DataGridCell<DeliveryReceipt>(columnName: 'more', value: e),
            ]))
        .toList(growable: false);
  }
}
