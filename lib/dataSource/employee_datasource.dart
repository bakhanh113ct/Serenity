import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/User.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<User> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.idUser),
              DataGridCell<String>(columnName: 'name', value: e.fullName),
              DataGridCell<String>(
                  columnName: 'date', value: e.dateOfBirth!.toString()),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<double>(
                  columnName: 'salary', value: e.salary!.toDouble()),
              DataGridCell<String>(columnName: 'status', value: 'active'),
              DataGridCell<String>(columnName: 'button', value: ''),
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ));
    }).toList());
  }
}
