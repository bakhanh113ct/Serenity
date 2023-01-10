import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/dataSource/employee_datasource.dart';
import 'package:serenity/model/User.dart';
import 'package:serenity/widget/modal_edit_employee.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/employee/employee_bloc.dart';

class TableEmployee extends StatefulWidget {
  const TableEmployee({super.key, required this.state});
  final String state;
  @override
  State<TableEmployee> createState() => _TableEmployeeState();
}

class _TableEmployeeState extends State<TableEmployee> {
  EmployeeDataSource? employeeDataSource;

  @override
  void initState() {
    super.initState();
  }

  String searchText = '';
  late Map<String, double> columnWidths = {
    'id': double.nan,
    'name': double.nan,
    'date': double.nan,
    'status': double.nan,
    'price': double.nan,
    'note': double.nan,
    'button': double.nan,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: Container(
        // height: 900,
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return Container();
            } else if (state is EmployeeLoaded) {
              List<User> data = state.listEmployee;
              if (widget.state != 'all') {
                if (widget.state == 'active') {
                  data = state.listEmployee
                      .where((element) => element.state == 'active')
                      .toList();
                } else {
                  data = state.listEmployee
                      .where((element) => element.state == 'inactive')
                      .toList();
                }
              }
              List<User> employees = data;
              employees = data
                  .where((element) =>
                      element.fullName!.toLowerCase().contains(searchText))
                  .toList();
              employeeDataSource = EmployeeDataSource(
                  employeeData: List.from(employees),
                  onPress: (user) {
                    showDialog<String>(
                      // barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        // title: const Text('AlertDialog Title'),
                        content: ModalEditEmployee(
                          user: user,
                        ),
                      ),
                    );
                  });
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                      context.read<EmployeeBloc>().add(UpdateListEmployee(
                          searchText: '', listUser: state.listEmployee));
                      // print(value);
                      // employees = data
                      //     .where((element) => element.fullName!.contains(value))
                      //     .toList();
                      // print(employees);
                      // employeeDataSource = EmployeeDataSource(
                      //     employeeData: List.from(employees),
                      //     onPress: (user) {
                      //       showDialog<String>(
                      //         // barrierDismissible: false,
                      //         context: context,
                      //         builder: (BuildContext context) => AlertDialog(
                      //           // title: const Text('AlertDialog Title'),
                      //           content: ModalEditEmployee(
                      //             user: user,
                      //           ),
                      //         ),
                      //       );
                      //     });
                      // setState(() {});
                    },
                    // obscureText: true,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        // enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: 'Search for orderID, customer'),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        gridLineColor: Colors.transparent,
                      ),
                      child: SfDataGrid(
                        rowHeight: 55,
                        // onQueryRowHeight: (details) =>
                        //     details.getIntrinsicRowHeight(details.rowIndex),
                        columnWidthMode: ColumnWidthMode.fill,
                        // columnResizeMode: ColumnResizeMode.onResize,
                        allowColumnsResizing: true,
                        onColumnResizeUpdate:
                            (ColumnResizeUpdateDetails details) {
                          // setState(() {
                          //   columnWidths[details.column.columnName] = details.width;
                          // });
                          return true;
                        },
                        source: employeeDataSource!,
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
                              columnName: 'date',
                              // width: columnWidths['date']!,
                              label: Container(
                                  // padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Date of birth',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'email',
                              // width: columnWidths['status']!,
                              label: Container(
                                  // padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'salary',
                              // width: columnWidths['price']!,
                              label: Container(
                                  // padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Salary',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'status',
                              // width: columnWidths['note']!,
                              label: Container(
                                  // padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'button',
                              // width: columnWidths['button']!,
                              label: Container(
                                  // padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
