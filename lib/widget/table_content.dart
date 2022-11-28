import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dataSource/import_order_datasource.dart';
import '../model/import_order.dart';

class TableContent extends StatefulWidget {
  const TableContent({
    Key? key,
    required this.employees,
  }) : super(key: key);
  final List<ImportOrder> employees;
  @override
  State<TableContent> createState() => _TableContentState();
}

class _TableContentState extends State<TableContent> {
  late ImportOrderDataSource employeeDataSource;

  @override
  void initState() {
    employeeDataSource = ImportOrderDataSource(employeeData: widget.employees);
    super.initState();
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
          height: 500,
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
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

  List<ImportOrder> getEmployeeData() {
    return [
      ImportOrder(
          nameA: 'CT TNHH Dung Cot',
          addressA: '22/35 abc',
          phoneA: '0395823456',
          bankA: '101287529',
          atBankA: 'VCB',
          authorizedPersonA: 'Nguyen Ba A',
          positionA: 'NV',
          noAuthorizationA: '1',
          dateAuthorizationA: Timestamp.now(),
          nameB: 'CT TNHH 3TV',
          addressB: '38/123 xyz, abcd',
          phoneB: '0395823456',
          bankB: '10213356745',
          atBankB: 'VCB',
          authorizedPersonB: 'Nguyen Van B',
          positionB: 'NVq',
          noAuthorizationB: '214532',
          dateAuthorizationB: Timestamp.now(),
          pursuant: '123abc',
          dateCreated: Timestamp.now(),
          atPlace: '12/245 qqwe',
          note: '',
          totalPrice: 200,
          idImportOrder: 'a7zSINGejYGBzDwhloeC',
          status: 'pending'),
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
}
