import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/Customer.dart';
import '../widget/customer_actionsButton.dart';
import '../widget/customerEdit_dialog.dart';

class CustomerDataSource extends DataGridSource {
  var id = '';
  final BuildContext context;
  List<DataGridRow> _customers = [];
  CustomerDataSource({required List<Customer> customers, required this.context}) {
    _customers = customers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              const DataGridCell<String>(columnName: 'actions', value: 'edit'),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'address', value: e.address),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<double>(columnName: 'purchased', value: e.purchased),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(
                  columnName: 'dateOfBirth', value: e.dateOfBirth),
            ]))
        .toList();
  }

 

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    id = row
        .getCells()
        .firstWhere(
            (DataGridCell dataGridCell) => dataGridCell.columnName == 'id')
        .value;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'purchased')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.columnName == 'actions'
            ? Center(child: CustomerActionsButton(id: id))
            : Center(
                child: Text(
                  (dataGridCell.columnName == 'purchased' ? '\$' : '') +
                      dataGridCell.value.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
      );
    }).toList());
  }
}
