import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'receipt_document_datasource.dart';

class ReceiptDocumentDataGrid extends StatefulWidget {
  const ReceiptDocumentDataGrid({
    Key? key,
    required this.receiptDocumentDataSource,
  }) : super(key: key);

  final ReceiptDocumentDataSource receiptDocumentDataSource;

  @override
  State<ReceiptDocumentDataGrid> createState() => _ReceiptDocumentDataGridState();
}

class _ReceiptDocumentDataGridState extends State<ReceiptDocumentDataGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
            columnResizeIndicatorColor: Theme.of(context).primaryColor,
            columnResizeIndicatorStrokeWidth: 2.0,
            frozenPaneElevation: 7.0),
        child: Column(
          children: [
            Expanded(
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.none,
                headerGridLinesVisibility: GridLinesVisibility.none,
                rowHeight: 70,
                columnWidthMode: ColumnWidthMode.fill,
                source: widget.receiptDocumentDataSource,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'no',
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('NO',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'nameSupplier',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('NameSupplier',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'amount',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Num of Order',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'totalPrice',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Total Price',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'dateCreated',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('DateCreated',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'more',
                      allowFiltering: false,
                      allowSorting: false,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('More',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
