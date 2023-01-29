import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'report_trouble_datasource.dart';


class ReportTroubleDataGrid extends StatefulWidget {
  const ReportTroubleDataGrid({
    Key? key,
    required this.reportTroubleDataSource,
  }) : super(key: key);

  final ReportTroubleDataSource reportTroubleDataSource;

  @override
  State<ReportTroubleDataGrid> createState() => _ReportTroubleDataGridState();
}

class _ReportTroubleDataGridState extends State<ReportTroubleDataGrid> {
  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
        data: SfDataGridThemeData(
            columnResizeIndicatorColor: Theme.of(context).primaryColor,
            columnResizeIndicatorStrokeWidth: 2.0,
            sortIcon: null,
            frozenPaneElevation: 7.0),
        child: Column(
          children: [
            Expanded(
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.none,
                headerGridLinesVisibility: GridLinesVisibility.none,
                rowHeight:60,
                columnWidthMode: ColumnWidthMode.fill,
                source: widget.reportTroubleDataSource,           
                columns: <GridColumn>[
                  GridColumn(
                      visible: false,
                      columnName: 'idReportTrouble',
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('id',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
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
                      columnName: 'nameCustomer',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('NameCustomer',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'totalMoney',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Total Money',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'isCompensate',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('IsCompensate',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'status',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Status',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'dateCreated',
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('DateCreated',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      columnName: 'more',
                      allowFiltering: false,
                      width: 70,
                      allowSorting: false,
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
