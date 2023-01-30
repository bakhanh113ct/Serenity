import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/screen/create_import_order.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/importOrder/import_order_bloc.dart';
import '../common/color.dart';
import '../dataSource/import_order_datasource.dart';
import '../model/import_order.dart';

class TableImportOrder extends StatefulWidget {
  const TableImportOrder({
    Key? key,
    required this.tab,
  }) : super(key: key);
  final String tab;
  @override
  State<TableImportOrder> createState() => _TableImportOrderState();
}

class _TableImportOrderState extends State<TableImportOrder> {
  late ImportOrderDataSource employeeDataSource;
  String searchText = '';
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TableImportOrder oldWidget) {
    // BlocProvider.of<ImportOrderBloc>(context).add(LoadImportOrder());
    super.didUpdateWidget(oldWidget);
  }

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
      child: SingleChildScrollView(
        child: Container(
          // height: 500,
          child: BlocBuilder<ImportOrderBloc, ImportOrderState>(
            builder: (context, state) {
              if (state is ImportOrderLoading) {
                return Container();
              } else if (state is ImportOrderLoaded) {
                List<ImportOrder> data = state.listImportOrder;
                if (widget.tab != 'All') {
                  data = state.listImportOrder
                      .where((element) =>
                          element.status == widget.tab.toLowerCase())
                      .toList();
                }
                print(searchText);

                List<ImportOrder> importOrders = data
                    .where((element) =>
                        element.nameB!.toLowerCase().contains(searchText) ||
                        element.idImportOrder!
                            .toLowerCase()
                            .contains(searchText))
                    .toList();

                employeeDataSource = ImportOrderDataSource(
                    importOrders: importOrders,
                    context: context,
                    onPress: (item) {});
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // obscureText: true,
                              controller: _queryController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  hintText:
                                      'Search for ID import, supplier name'),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: CustomColor.second),
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  searchText = _queryController.text;
                                });
                                context.read<ImportOrderBloc>().add(
                                    UpdateListImportOrder(
                                        listImportOrder:
                                            state.listImportOrder));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // TextField(
                    //   onChanged: (value) {
                    //     setState(() {
                    //       searchText = value;
                    //     });
                    //     context.read<ImportOrderBloc>().add(
                    //         UpdateListImportOrder(
                    //             listImportOrder: state.listImportOrder));
                    //   },
                    //   decoration: const InputDecoration(
                    //       contentPadding:
                    //           EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    //       border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(30))),
                    //       // enabledBorder: OutlineInputBorder(
                    //       //     borderSide: BorderSide(color: Colors.black)),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.black),
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(30))),
                    //       icon: Icon(
                    //         Icons.search,
                    //         color: Colors.black,
                    //       ),
                    //       hintText: 'Search for orderID, customer'),
                    //   style: const TextStyle(fontSize: 16),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 550,
                        child: SfDataGridTheme(
                          data: SfDataGridThemeData(
                            gridLineColor: Colors.transparent,
                          ),
                          child: SfDataGrid(
                            rowHeight: 60,
                            // onQueryRowHeight: (details) =>
                            //     details.getIntrinsicRowHeight(details.rowIndex),
                            columnWidthMode: ColumnWidthMode.fill,
                            // columnResizeMode: ColumnResizeMode.onResize,
                            allowColumnsResizing: true,
                            onColumnResizeUpdate:
                                (ColumnResizeUpdateDetails details) {
                              setState(() {
                                columnWidths[details.column.columnName] =
                                    details.width;
                              });
                              return true;
                            },

                            // gridLinesVisibility: GridLinesVisibility.both,
                            source: employeeDataSource,
                            // columnWidthMode: ColumnWidthMode.fill,
                            columns: <GridColumn>[
                              GridColumn(
                                  columnName: 'STT',
                                  // width: columnWidths['id']!,
                                  width: 120,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'ID',
                                        style: TextStyle(
                                            fontSize: 22,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Supplier Name',
                                        maxLines: 5,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(0xFF226B3F),
                                        ),
                                      ))),
                              GridColumn(
                                  columnName: 'date',
                                  // width: columnWidths['date']!,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Date Created',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF226B3F)),
                                      ))),
                              GridColumn(
                                  columnName: 'status',
                                  // width: columnWidths['status']!,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Status',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF226B3F)),
                                      ))),
                              GridColumn(
                                  columnName: 'price',
                                  // width: columnWidths['price']!,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Price',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF226B3F)),
                                      ))),
                              GridColumn(
                                  columnName: 'note',
                                  // width: columnWidths['note']!,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Note',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF226B3F)),
                                      ))),
                              GridColumn(
                                  columnName: 'button',
                                  width: 60,
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'More',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF226B3F)),
                                      ))),
                            ],
                          ),
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
      ),
    );
  }
}
