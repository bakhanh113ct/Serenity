import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/user.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/order.dart';


class OrderDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  OrderDataSource({required List<MyOrder> orderData}) {
    _orderData = orderData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'idOrder', value: e.idOrder!),
              DataGridCell<String>(columnName: 'dateCreated', value: e.dateCreated!.toDate().toString()),
              DataGridCell<String>(columnName: 'nameCustomer', value: e.nameCustomer),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'price', value: e.price),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
            ]))
        .toList();
  }

  List<DataGridRow> _orderData = [];

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
                      print(e.value.toString());
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