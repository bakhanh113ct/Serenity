import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'customer_datasource.dart';

class CustomerDataGrid extends StatefulWidget {
  const CustomerDataGrid({
    Key? key,
    required this.customerDataSource,
  }) : super(key: key);

  final CustomerDataSource customerDataSource;


  @override
  State<CustomerDataGrid> createState() => _CustomerDataGridState();
}

class _CustomerDataGridState extends State<CustomerDataGrid> {
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
                source: widget.customerDataSource,

                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'idCustomer',
                      visible: false,
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
                      columnName: 'name',
                     
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Name',
                              style: Theme.of(context).textTheme.headline2,
                              overflow: TextOverflow.ellipsis))),    
                  GridColumn(
                      columnName: 'email',
                     
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: Theme.of(context).textTheme.headline2,
                             overflow: TextOverflow.ellipsis
                          ))),
                  GridColumn(
                      columnName: 'phone',
                     
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Phone',
                            style: Theme.of(context).textTheme.headline2,
                             overflow: TextOverflow.ellipsis
                          ))),
                  GridColumn(
                      columnName: 'purchased',
                     
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Purchased',
                            style: Theme.of(context).textTheme.headline2,
                             overflow: TextOverflow.ellipsis
                          ))),
                  GridColumn(
                      columnName: 'dateOfBirth',
                     
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'DateOfBirth',
                            style: Theme.of(context).textTheme.headline2,
                             overflow: TextOverflow.ellipsis
                          ))),
                  GridColumn(
                      columnName: 'more',                    
                      allowFiltering: false,
                      allowSorting: false,
                      width: 70,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'More',
                            style: Theme.of(context).textTheme.headline2,
                             overflow: TextOverflow.ellipsis
                          ))),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
