import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'export_book_datasource.dart';

class ExportBookDataGrid extends StatefulWidget {
  const ExportBookDataGrid({
    Key? key,
    required this.exportBookDataSource,
  }) : super(key: key);

  final ExportBookDataSource exportBookDataSource;

  @override
  State<ExportBookDataGrid> createState() => _ExportBookDataGridState();
}

class _ExportBookDataGridState extends State<ExportBookDataGrid> {
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
                source: widget.exportBookDataSource,
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
                      columnName: 'name',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Name',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'price',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Total Price',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'amount',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Amount',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'category',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Category',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'dateExport',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Date Export',
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
