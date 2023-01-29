import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocDetailOrder/bloc/detail_order_bloc.dart';
import 'package:serenity/bloc/blocOrder/order_bloc.dart';
import 'package:serenity/common/color.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dataSource/order_datasource.dart';
import '../model/order.dart';


class TableOrder extends StatefulWidget {
  const TableOrder({super.key, required this.orders});
  final OrderDataSource orders;
  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  // late OrderDataSource orderDataSource;
  final DataGridController _dataGridController = DataGridController();
  @override
  void initState() {
    super.initState();
  }

  late Map<String, double> columnWidths = {
    'idOrder': double.nan,
    'idUser': double.nan,
    'idCustomer': double.nan,
    'status': double.nan,
    'button': double.nan,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(onPressed: (){
            //   print(_dataGridController.selectedRow!.getCells()[0].value);
            //   _showDetail(_dataGridController.selectedRow!.getCells()[0].value);}, child: Text("in")),
            Container(
              // color: Colors.black,
              // height: 400,
              child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        gridLineColor: Colors.transparent,
                      ),
                      child: SfDataGrid(
                        selectionMode: SelectionMode.single,
                        
                        controller: _dataGridController,
                        rowHeight: 70,
                        onQueryRowHeight: (details) =>
                            details.getIntrinsicRowHeight(details.rowIndex),
                        columnWidthMode: ColumnWidthMode.fill,
                        columnResizeMode: ColumnResizeMode.onResize,
                        allowColumnsResizing: true,
                        onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                          setState(() {
                            columnWidths[details.column.columnName] = details.width;
                          });
                          return true;
                        },
                        // gridLinesVisibility: GridLinesVisibility.both,
                        source: widget.orders,
                        // columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'idOrder',
                              // width: columnWidths['idOrder']!,
                              width: 150,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'ID',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              // maximumWidth: 200,
                              width: 200,
                              // columnWidthMode: ColumnWidthMode.auto,
                              columnName: 'dateCrated',
                              // width: columnWidths['name']!,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Created',
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xFF226B3F),
                                    ),
                                  ))),
                          GridColumn(
                              columnName: 'nameCustomer',
                              // width: columnWidths['idCustomer']!,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Customer',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'status',
                              // width: columnWidths['status']!,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                            GridColumn(
                              columnName: 'price',
                              // width: columnWidths['status']!,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                          GridColumn(
                              columnName: 'button',
                              // width: columnWidths['button']!,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'More',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF226B3F)),
                                  ))),
                        ],
                      ),
                    )
            ),
          ],
        ),
      ),
    );
  }
  void _showDetail(String idOrder) {
    BlocProvider.of<DetailOrderBloc>(context).add(LoadDetailOrder(idOrder));
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<DetailOrderBloc, DetailOrderState>(
          builder: (context, state) {
            if(state is DetailOrderLoading){
              return Container();
            }
            else if(state is DetailOrderLoaded){
              final date = DateTime.fromMillisecondsSinceEpoch(state.order!.dateCreated!.millisecondsSinceEpoch);
              return Dialog(
              child: Container(
                height: 700,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(child: Text("Detail Order",style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600,),)),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Id Order:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        Text(state.order!.idOrder.toString(),style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Customer:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        Text(state.order!.nameCustomer.toString(),style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        Text(state.order!.phone.toString(),style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Created:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        Text(DateFormat('hh:mm dd/MM/yyyy').format(date),style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("List Items:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),), 
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.listDetailOrder.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(state.listDetailOrder[index].name!+"  x"+state.listDetailOrder[index].amount.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                            Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(double.tryParse(state.listDetailOrder[index].price!)),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                   
                                                    ))
                          ],);
                      },),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Total",style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFA5A6A8)),),
                      Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(double.tryParse(state.order!.price!)),
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black))
                    ],),
                    SizedBox(height: 20,),
                    state.order!.status=="Pending"?ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(255, 239, 75, 75),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 60),
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<DetailOrderBloc>(context).add(CancelDetailOrder());
                                              BlocProvider.of<OrderBloc>(context).add(LoadOrder());
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 18),
                                            )):Container(),
                                            SizedBox(height: 20,),
                ]),),
              ));
            }
            else{
              return Container();
            }
          },
        );
      },
    );
  }
}