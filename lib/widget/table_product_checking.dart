import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/dataSource/product_datasource.dart';
import 'package:serenity/model/product.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/importOrder/import_order_bloc.dart';
import '../dataSource/import_order_datasource.dart';
import '../dataSource/product_checking_datasource.dart';
import '../model/import_order.dart';

class TableProductChecking extends StatefulWidget {
  const TableProductChecking(
      {super.key, required this.importOrder, required this.onOpenReport});
  final ImportOrder importOrder;
  final Function onOpenReport;
  @override
  State<TableProductChecking> createState() => _TableProductCheckingState();
}

class _TableProductCheckingState extends State<TableProductChecking> {
  late ProductCheckingDataSource productDataSource;
  List<bool>? _listChoose;
  bool choose = true;
  @override
  void initState() {
    _listChoose = widget.importOrder.listProduct!.map((e) => false).toList();

    int i = 0;
    productDataSource = ProductCheckingDataSource(
        productData: widget.importOrder.listProduct!,
        onPress: widget.onOpenReport,
        onChoose: (int index, value) {
          // choose = !choose;
          // print(index.toString() + '/' + value.toString());
          _listChoose![index] = value;
        },
        isChoose: choose,
        context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 300,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: Colors.transparent,
                ),
                child: SfDataGrid(
                  allowEditing: true,
                  rowHeight: 55,
                  columnWidthMode: ColumnWidthMode.fill,
                  allowColumnsResizing: true,
                  onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                    return true;
                  },
                  source: productDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                        width: 60,
                        columnName: 'STT',
                        // width: columnWidths['id']!,
                        label: Container(
                            // padding: EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'STT',
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
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Name',
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xFF226B3F),
                              ),
                            ))),
                    GridColumn(
                        columnName: 'price',
                        // width: columnWidths['date']!,
                        label: Container(
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Price',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF226B3F)),
                            ))),
                    GridColumn(
                        columnName: 'amount',
                        // width: columnWidths['status']!,
                        label: Container(
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Amount',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF226B3F)),
                            ))),
                    GridColumn(
                        columnName: 'note',
                        // width: columnWidths['note']!,
                        label: Container(
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Note',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF226B3F)),
                            ))),
                    GridColumn(
                        columnName: 'check',
                        // width: columnWidths['price']!,
                        label: Container(
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Check',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF226B3F)),
                            ))),
                    GridColumn(
                        columnName: 'button',
                        // width: columnWidths['note']!,
                        label: Container(
                            // padding: EdgeInsets.all(8.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'More',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF226B3F)),
                            ))),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_listChoose!.any((element) => element == false)) {
                    Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 300, vertical: 16),
                      borderRadius: BorderRadius.circular(8),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      title: 'Notification',
                      message: 'Please check full',
                      duration: const Duration(seconds: 3),
                    ).show(context);
                  } else {
                    BlocProvider.of<ImportOrderBloc>(context).add(
                        UpdateStateImportOrder(
                            idImportOrder: widget.importOrder.idImportOrder!,
                            state: 'checked'));
                  }
                  // ImportOrderBloc().add(UpdateStateImportOrder(
                  // idImportOrder: widget.importOrder.idImportOrder!,
                  // state: 'Checked'));
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
