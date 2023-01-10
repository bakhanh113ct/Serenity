import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/dataSource/product_datasource.dart';
import 'package:serenity/model/product.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dataSource/import_order_datasource.dart';
import '../model/import_order.dart';

class TableProduct extends StatefulWidget {
  const TableProduct(
      {super.key, required this.products, required this.onPress});
  final List<ProductImportOrder> products;
  final Function onPress;
  @override
  State<TableProduct> createState() => _TableProductState();
}

class _TableProductState extends State<TableProduct> {
  ProductDataSource? productDataSource;

  @override
  void initState() {
    // print('table product init');
    productDataSource = ProductDataSource(
        productData: widget.products,
        onPress: widget.onPress,
        context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // print('did change');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TableProduct oldWidget) {
    // print('change');
    // setState(() {});
    productDataSource = ProductDataSource(
        productData: widget.products,
        onPress: widget.onPress,
        context: context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          height: 500,
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
              source: productDataSource!,
              columns: <GridColumn>[
                GridColumn(
                    width: 60,
                    columnName: 'STT',
                    // width: columnWidths['id']!,
                    label: Container(
                        // padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
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
                        child: Text(
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
                        child: Text(
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
                        child: Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF226B3F)),
                        ))),
                GridColumn(
                    columnName: 'totalPrice',
                    // width: columnWidths['price']!,
                    label: Container(
                        // padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Total Price',
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
                        child: Text(
                          'Note',
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
                        child: Text(
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
      ),
    );
  }
}
