import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/Customer.dart';
import '../widget/customerWidget/customer_actionsButton.dart';

class CustomerDataSource extends DataGridSource {
  var id = '';
  final BuildContext context;
  List<DataGridRow> _customers = [];
  List<Customer> _paginatedCustomers = [];
  List<Customer> allCustomers = [];
  int newRowsPerPage = 1;
  CustomerDataSource(
      {required List<Customer> customers, required this.context}) {
    if (customers.isEmpty) return;
    allCustomers = customers;
    _paginatedCustomers = allCustomers.getRange(0, 1).toList(growable: false);
    buildPaginatedDataGridRows();
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
            : (dataGridCell.columnName == 'imageUrl'
                ? Center(
                    child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(dataGridCell.value.toString()),
                  ))
                : Center(
                    child: Text(
                      (dataGridCell.columnName == 'purchased' ? '\$' : '') +
                          dataGridCell.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )),
      );
    }).toList());
  }

  void buildPaginatedDataGridRows() {
    _customers = _paginatedCustomers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              const DataGridCell<String>(columnName: 'actions', value: 'edit'),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'address', value: e.address),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<double>(columnName: 'purchased', value: e.purchased),

              DataGridCell<String>(
                  columnName: 'dateOfBirth', value: e.dateOfBirth),
            ]))
        .toList(growable: false);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
    final int startIndex = newPageIndex * RowsPerPage.row;
    int endIndex = startIndex + RowsPerPage.row;
    if (endIndex > allCustomers.length) {
      endIndex = allCustomers.length;
    }

    /// Get particular range from the sorted collection.
    if (startIndex < allCustomers.length && endIndex <= allCustomers.length) {
      _paginatedCustomers =
          allCustomers.getRange(startIndex, endIndex).toList();
    } else {
      _paginatedCustomers = <Customer>[];
    }
    buildPaginatedDataGridRows();
    notifyListeners();
    return Future<bool>.value(true);
  }

  void updateDataGriDataSource(int rowsPerPage) {
    newRowsPerPage = rowsPerPage;
    notifyListeners();
  }
  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    buildPaginatedDataGridRows();
    notifyListeners();
  }
}
class RowsPerPage {
 static int row = 1;
}
