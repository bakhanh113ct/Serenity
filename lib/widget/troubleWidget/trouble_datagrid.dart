import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'trouble_datasource.dart';


class TroubleDataGrid extends StatefulWidget {
  const TroubleDataGrid({
    Key? key,
    required this.troubleDataSource,
  }) : super(key: key);

  final TroubleDataSource troubleDataSource;

  @override
  State<TroubleDataGrid> createState() => _TroubleDataGridState();
}

class _TroubleDataGridState extends State<TroubleDataGrid> {
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
                source: widget.troubleDataSource,
                allowSorting: true,
                columns: <GridColumn>[
                  GridColumn(
                      visible: false,
                      columnName: 'idTrouble',
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('id',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
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
                      columnName: 'nameCustomer',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('NameCustomer',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'description',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Description',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'status',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text('Status',
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
