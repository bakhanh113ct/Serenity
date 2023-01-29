import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/User.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class EmployeeDataSource extends DataGridSource {
  int i = 0;
  Function? onPress;

  /// Creates the employee data source class with required details.
  EmployeeDataSource(
      {required List<User> employeeData, required Function this.onPress}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'STT', value: e.idUser),
              DataGridCell<String>(columnName: 'name', value: e.fullName),
              DataGridCell<String>(
                  columnName: 'date',
                  value:
                      '${e.dateOfBirth!.toDate().day}/${e.dateOfBirth!.toDate().month}/${e.dateOfBirth!.toDate().year}'),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<int>(columnName: 'salary', value: e.salary!),
              DataGridCell<String>(columnName: 'status', value: e.state),
              DataGridCell<User>(columnName: 'button', value: e),
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
      Color backgroundColor = Colors.white;
      Color textColor = Colors.white;
      final format = NumberFormat("###,###.###", "tr_TR");
      if (e.columnName == 'status') {
        if (e.value == 'active') {
          backgroundColor = Color(0xFFDCFBD7);
          textColor = Color(0xFF5CB16F);
        } else {
          backgroundColor = Color(0xFFFFEFEF);
          textColor = Color(0xFFFD2B2B);
        }
      }

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
                    onPressed: () {
                      if (onPress != null) {
                        onPress!(e.value);
                      }
                    },
                  ),
                )
              : e.columnName == 'status'
                  ? Container(
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        e.value,
                        style: TextStyle(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Text(
                      e.columnName == 'STT'
                          ? (i++).toString()
                          : e.columnName == 'salary'
                              ? format.format(e.value)
                              : e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ));
    }).toList());
  }
}
