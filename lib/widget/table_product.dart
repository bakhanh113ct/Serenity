import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dataSource/import_order_datasource.dart';
import '../model/import_order.dart';

class TableProduct extends StatefulWidget {
  const TableProduct({super.key});

  @override
  State<TableProduct> createState() => _TableProductState();
}

class _TableProductState extends State<TableProduct> {
  List<ImportOrder> employees = <ImportOrder>[];
  late ImportOrderDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource =
        ImportOrderDataSource(employeeData: employees, context: context);
  }

  List<ImportOrder> getEmployeeData() {
    return [
      // ImportOrder(
      //     '10001', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10002', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10003', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10004', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10005', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10006', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
      // ImportOrder(
      //     '10007', 'James', Timestamp.now(), 'completed', 20000, 'aaaa'),
    ];
  }

  late Map<String, double> columnWidths = {
    'id': double.nan,
    'name': double.nan,
    'date': double.nan,
    'status': double.nan,
    'price': double.nan,
    'note': double.nan,
    'button': double.nan,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          height: 400,
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineColor: Colors.transparent,
            ),
            child: SfDataGrid(
              rowHeight: 55,
              onQueryRowHeight: (details) =>
                  details.getIntrinsicRowHeight(details.rowIndex),
              columnWidthMode: ColumnWidthMode.fill,
              columnResizeMode: ColumnResizeMode.onResize,
              allowColumnsResizing: true,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                setState(() {
                  columnWidths[details.column.columnName] = details.width;
                });
                return true;
              },

              // gridLinesVisibility: GridLinesVisibility.both,
              source: employeeDataSource,
              // columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    width: columnWidths['id']!,
                    label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    // maximumWidth: 200,
                    width: 200,
                    // columnWidthMode: ColumnWidthMode.auto,
                    columnName: 'name',
                    // width: columnWidths['name']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Supplier Name',
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xFF226B3F),
                          ),
                        ))),
                GridColumn(
                    columnName: 'date',
                    width: columnWidths['date']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date Created',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    columnName: 'status',
                    width: columnWidths['status']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    columnName: 'price',
                    width: columnWidths['price']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    columnName: 'note',
                    width: columnWidths['note']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Note',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    columnName: 'button',
                    width: columnWidths['button']!,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
