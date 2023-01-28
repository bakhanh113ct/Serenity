

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocOrder/order_bloc.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/blocDetailOrder/bloc/detail_order_bloc.dart';
import '../model/order.dart';


class OrderDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  BuildContext context;
  OrderDataSource({required List<MyOrder> orderData, required BuildContext this.context}) {

    _orderData = orderData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'idOrder', value: e.idOrder),
              DataGridCell<String>(columnName: 'dateCreated', value: e.dateCreated!.toDate().toString()),
              DataGridCell<String>(columnName: 'nameCustomer', value: e.nameCustomer),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'price', value: e.price),
              DataGridCell<String>(columnName: 'button', value: e.idOrder),
            ]))
        .toList();
  }

  List<DataGridRow> _orderData = [];
  void _showDetail(String idOrder, BuildContext context) {
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
                                              backgroundColor: CustomColor.second,
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
                                              BlocProvider.of<DetailOrderBloc>(context).add(CompleteDetailOrder());
                                              BlocProvider.of<OrderBloc>(context).add(LoadOrder());
                                            },
                                            child: Text(
                                              "Complete",
                                              style: TextStyle(fontSize: 18),
                                            )):Container(),
                                            SizedBox(height: 20,),
                    SizedBox(height: 10,),
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
  @override
  List<DataGridRow> get rows => _orderData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
          alignment: e.columnName!='idOrder'? Alignment.centerLeft:Alignment.centerRight,
          // height: 100,
          padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? Material(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showDetail(e.value.toString(),context);
                    },
                  ),
                )
              : e.columnName == 'status'
                  ? _StatusText(e.value.toString())
                  : Text(
                      e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w400),
                    ));
    }).toList());
  }
}

Widget _StatusText(String e){
  if(e=="Completed"){
    return Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFDCFBD7),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child:Text(
                        e,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5CB16F),
                            fontWeight: FontWeight.w500),
                      ),
                    );
  }
  else if (e=="Pending"){
    return Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFFEFFCB),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child:Text(
                        e,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFEDB014),
                            fontWeight: FontWeight.w500),
                      ),
                    );
  }
  else{
    return Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFEFEF),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child:Text(
                        e,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFD2B2B),
                            fontWeight: FontWeight.w500),
                      ),
                    );
  }
}