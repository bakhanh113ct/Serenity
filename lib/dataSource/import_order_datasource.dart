import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class ImportOrderDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  ImportOrderDataSource({required List<ImportOrder> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.supplierName),
              DataGridCell<String>(
                  columnName: 'date',
                  value: e.dateCreated.toDate().day.toString() +
                      '/' +
                      e.dateCreated.toDate().month.toString() +
                      '/' +
                      e.dateCreated.toDate().year.toString()),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<double>(columnName: 'price', value: e.price),
              DataGridCell<String>(columnName: 'note', value: e.note),
              DataGridCell<String>(columnName: 'button', value: e.note),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
          alignment: Alignment.centerLeft,
          // height: 100,
          // padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: IconButton(
                    splashRadius: 20,
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                )
              : e.columnName == 'status'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFDCFBD7),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5CB16F),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Text(
                      e.value.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ));
    }).toList());
  }
}
