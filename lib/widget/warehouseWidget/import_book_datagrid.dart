import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'import_book_datasource.dart';

class ImportBookDataGrid extends StatefulWidget {
  const ImportBookDataGrid({
    Key? key,
    required this.importBookDataSource,
  }) : super(key: key);

  final ImportBookDataSource importBookDataSource;

  @override
  State<ImportBookDataGrid> createState() =>
      _ImportBookDataGridState();
}

class _ImportBookDataGridState extends State<ImportBookDataGrid> {
  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
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
                rowHeight: 60,
                columnWidthMode: ColumnWidthMode.fill,
                source: widget.importBookDataSource,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'no',
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('NO',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Name',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'price',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Total Price',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'amount',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Amount',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'category',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Category',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'content',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Content',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                              
                  GridColumn(
                      columnName: 'more',
                      allowFiltering: false,
                      allowSorting: false,
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('More',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
