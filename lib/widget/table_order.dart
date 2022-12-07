import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/bloc/blocOrder/order_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dataSource/order_datasource.dart';
import '../model/order.dart';


class TableOrder extends StatefulWidget {
  const TableOrder({super.key, required this.orders});
  final OrderDataSource orders;
  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  // late OrderDataSource orderDataSource;

  @override
  void initState() {
    super.initState();
  }

  late Map<String, double> columnWidths = {
    'idOrder': double.nan,
    'idUser': double.nan,
    'idCustomer': double.nan,
    'status': double.nan,
    'button': double.nan,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.black,
          // height: 400,
          child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    gridLineColor: Colors.transparent,
                  ),
                  child: SfDataGrid(
                    rowHeight: 70,
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
                    source: widget.orders,
                    // columnWidthMode: ColumnWidthMode.fill,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'idOrder',
                          // width: columnWidths['idOrder']!,
                          width: 150,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerRight,
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
                          columnName: 'dateCrated',
                          // width: columnWidths['name']!,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Created',
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(0xFF226B3F),
                                ),
                              ))),
                      GridColumn(
                          columnName: 'nameCustomer',
                          // width: columnWidths['idCustomer']!,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Customer',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF226B3F)),
                              ))),
                      GridColumn(
                          columnName: 'status',
                          // width: columnWidths['status']!,
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
                          // width: columnWidths['status']!,
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
                          columnName: 'button',
                          // width: columnWidths['button']!,
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF226B3F)),
                              ))),
                    ],
                  ),
                )
        ),
      ),
    );
  }
}