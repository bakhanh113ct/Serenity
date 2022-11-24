import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../datasource/customer_datasource.dart';

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
      padding: const EdgeInsets.all(50.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              columnResizeIndicatorColor: Theme.of(context).primaryColor,
              columnResizeIndicatorStrokeWidth: 2.0,
            ),
            child: SfDataGrid(
              onCellTap: (value) {
                print(value);
              },
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
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'actions',
                    minimumWidth: 100,               
                    width: widget.columnWidths['actions'] as double,
                    label: Container(
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Actions',
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
                          'ID',
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
                    columnName: 'imageUrl',
                    minimumWidth: 100,
                    width: widget.columnWidths['imageUrl'] as double,
                    label: Container(
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        child: Text(
                          'ImageUrl',
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
        ),
      ),
    );
  }
}
