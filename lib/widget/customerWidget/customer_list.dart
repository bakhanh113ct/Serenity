import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../datasource/customer_datasource.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key? key,
    required this.customerDataSource,
    required this.columnWidths,
  }) : super(key: key);

  final CustomerDataSource customerDataSource;
  final Map<String, double> columnWidths;

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SfDataGridTheme(

            data: SfDataGridThemeData(
              columnResizeIndicatorColor: Theme.of(context).primaryColor,
              columnResizeIndicatorStrokeWidth: 2.0,
              frozenPaneElevation: 7.0
            ),
            child: Column(
              children: [
                Expanded(
                  child: SfDataGrid(
                    frozenColumnsCount: 1,
                    allowSorting: true,  
                    allowFiltering: true,
                    allowPullToRefresh: true,
                    source: widget.customerDataSource,
                    gridLinesVisibility: GridLinesVisibility.none,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    allowColumnsResizing: true,
                    rowHeight: MediaQuery.of(context).size.height * 0.1,
                    onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                      setState(() {
                        widget.columnWidths[details.column.columnName] =
                            details.width;
                      });
                      return true;
                    },
                    onQueryRowHeight: (details) {
                      return details.getIntrinsicRowHeight(details.rowIndex) - 200;
                    },
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'actions',
                          minimumWidth: 100, 
                          allowFiltering: false, 
                          allowSorting: false,             
                          width: widget.columnWidths['actions'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                '',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                      columnName: 'imageUrl',
                      minimumWidth: 100,
                      allowFiltering: false,
                      allowSorting: false,
                      width: widget.columnWidths['imageUrl'] as double,
                      label: Container(
                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Photo',
                            style: Theme.of(context).textTheme.headline2,
                          ))),
                      GridColumn(
                          columnName: 'id',
                          minimumWidth: 100,
                          width: widget.columnWidths['actions'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Id',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                        
                          columnName: 'name',
                          minimumWidth: 100,
                          width: widget.columnWidths['name'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Name',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                          columnName: 'address',
                          minimumWidth: 100,
                          width: widget.columnWidths['address'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Address',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                          columnName: 'email',
                          minimumWidth: 100,
                          width: widget.columnWidths['address'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Email',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                          columnName: 'phone',
                          minimumWidth: 100,
                          width: widget.columnWidths['phone'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Phone',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                      GridColumn(
                          columnName: 'purchased',
                          minimumWidth: 100,
                          width: widget.columnWidths['purchased'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Purchased',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                               GridColumn(
                          columnName: 'dateOfBirth',
                          minimumWidth: 100,
                          width: widget.columnWidths['dateOfBirth'] as double,
                          label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'DateOfBirth',
                                style: Theme.of(context).textTheme.headline2,
                              ))),
                        
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
