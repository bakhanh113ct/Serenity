// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/User.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/custom_checkbox.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class ProductCheckingDataSource extends DataGridSource {
  int i = 1;
  Function onPress;
  Function onChoose;
  BuildContext context;
  List<ProductImportOrder> productData;
  List<bool> listChoose;
  List<String> listTrouble;

  /// Creates the employee data source class with required details.
  ProductCheckingDataSource({
    required this.onPress,
    required this.onChoose,
    required this.context,
    required this.productData,
    required this.listChoose,
    required this.listTrouble,
  }) {
    _employeeData = productData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'STT', value: e.product!.idProduct),
              DataGridCell<String>(columnName: 'name', value: e.product!.name),
              DataGridCell<String>(
                  columnName: 'price', value: e.product!.price),
              DataGridCell<int>(columnName: 'amount', value: e.amount!),
              DataGridCell<String>(columnName: 'note', value: e.note),
              DataGridCell<ProductImportOrder>(columnName: 'check', value: e),
              DataGridCell<ProductImportOrder>(columnName: 'button', value: e),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      int index = 0;
      if (e.columnName == 'check' || e.columnName == 'button') {
        index = productData.indexWhere((element) => element == e.value);
      }
      return Container(
          alignment: Alignment.centerLeft,
          // height: 100,
          // padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? IconButton(
                  onPressed: () {
                    onPress(index, listTrouble[index]);
                  },
                  icon: const Icon(
                    Icons.flag, color: Colors.black,
                    // listTrouble[index] != ''
                    //     ? const Color(0xFFFD2B2B)
                    //     : Colors.black,
                  ))
              : e.columnName == 'check'
                  ? CustomCheckbox(
                      listTrouble: listTrouble,
                      onPress: onChoose,
                      index: index,
                      isChecked: listChoose[index],
                    )
                  : Text(
                      e.columnName == 'STT'
                          ? (i++).toString()
                          : e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ));
    }).toList());
  }

  // ProductCheckingDataSource copyWith({
  //   int? i,
  //   Function? onPress,
  //   Function? onChoose,
  //   BuildContext? context,
  //   List<ProductImportOrder>? productData,
  //   List<bool>? listChoose,
  //   List<String>? listTrouble,
  // }) {
  //   return ProductCheckingDataSource(
  //     i: i ?? this.i,
  //     onPress: onPress ?? this.onPress,
  //     onChoose: onChoose ?? this.onChoose,
  //     context: context ?? this.context,
  //     productData: productData ?? this.productData,
  //     listChoose: listChoose ?? this.listChoose,
  //     listTrouble: listTrouble ?? this.listTrouble,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'i': i,
  //     'onPress': onPress.toMap(),
  //     'onChoose': onChoose.toMap(),
  //     'context': context.toMap(),
  //     'productData': productData.map((x) => x.toMap()).toList(),
  //     'listChoose': listChoose,
  //     'listTrouble': listTrouble,
  //   };
  // }

  // factory ProductCheckingDataSource.fromMap(Map<String, dynamic> map) {
  //   return ProductCheckingDataSource(
  //     i: map['i'] as int,
  //     onPress: Function.fromMap(map['onPress'] as Map<String,dynamic>),
  //     onChoose: Function.fromMap(map['onChoose'] as Map<String,dynamic>),
  //     context: BuildContext.fromMap(map['context'] as Map<String,dynamic>),
  //     productData: List<ProductImportOrder>.from((map['productData'] as List<int>).map<ProductImportOrder>((x) => ProductImportOrder.fromMap(x as Map<String,dynamic>),),),
  //     listChoose: List<bool>.from((map['listChoose'] as List<bool>),
  //     listTrouble: List<String>.from((map['listTrouble'] as List<String>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProductCheckingDataSource.fromJson(String source) => ProductCheckingDataSource.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ProductCheckingDataSource(i: $i, onPress: $onPress, onChoose: $onChoose, context: $context, productData: $productData, listChoose: $listChoose, listTrouble: $listTrouble)';
  // }

  // @override
  // bool operator ==(covariant ProductCheckingDataSource other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.i == i &&
  //     other.onPress == onPress &&
  //     other.onChoose == onChoose &&
  //     other.context == context &&
  //     listEquals(other.productData, productData) &&
  //     listEquals(other.listChoose, listChoose) &&
  //     listEquals(other.listTrouble, listTrouble);
  // }

  // @override
  // int get hashCode {
  //   return i.hashCode ^
  //     onPress.hashCode ^
  //     onChoose.hashCode ^
  //     context.hashCode ^
  //     productData.hashCode ^
  //     listChoose.hashCode ^
  //     listTrouble.hashCode;
  // }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit, remove];
  // static const List<MenuItem> secondItems = [importVoucher];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const remove = MenuItem(text: 'Remove', icon: Icons.delete);
  // static const check = MenuItem(text: 'Check', icon: Icons.checklist);
  // static const importVoucher =
  //     MenuItem(text: 'Payment voucher', icon: Icons.edit_note);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, Function onPress,
      ProductImportOrder product, int index) {
    switch (item) {
      case MenuItems.edit:
        onPress();
        break;
      case MenuItems.remove:
        onPress();
        break;
    }
  }
}
