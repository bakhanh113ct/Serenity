import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/Customer.dart';
import 'customer_moreButton.dart';

class CustomerDataSource extends DataGridSource {
  var phone = '';
  final BuildContext context;
  List<DataGridRow> _customers = [];
   List<Customer> allCustomers = [];
  int newRowsPerPage = 1;
  CustomerDataSource(
      {required List<Customer> customers, required this.context}) {
    if (customers.isEmpty) return;
    allCustomers = customers;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    var idCustomer = row
        .getCells()
        .firstWhere(
            (DataGridCell dataGridCell) => dataGridCell.columnName == 'idCustomer')
        .value;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'purchased')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.columnName == 'more'
            ? Center(child: CustomerMoreButton(idCustomer: idCustomer)) : Center(
                    child: Text(
                      (dataGridCell.columnName == 'purchased' ? '\$' : '') +
                          dataGridCell.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
      );
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _customers = allCustomers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'idCustomer', value: e.idCustomer),
              DataGridCell<int>(columnName: 'no', value: i++),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<double>(columnName: 'purchased', value: double.tryParse(e.purchased.toString())),
              DataGridCell<String>(
                  columnName: 'dateOfBirth', value: DateFormat('dd/MM/yyyy').format(e.dateOfBirth!.toDate())),
              const DataGridCell<String>(columnName: 'more', value: 'edit'),
            ]))
        .toList(growable: false);
  }
}
