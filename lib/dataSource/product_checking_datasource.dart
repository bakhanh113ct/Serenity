// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<bool> importOrder;

  /// Creates the employee data source class with required details.
  ProductCheckingDataSource({
    required this.onPress,
    required this.onChoose,
    required this.context,
    required this.productData,
    required this.importOrder,
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
      if (e.columnName == 'check') {
        index = productData.indexWhere((element) => element == e.value);
      }
      return Container(
          alignment: Alignment.centerLeft,
          // height: 100,
          // padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? IconButton(
                  onPressed: () {
                    onPress();
                  },
                  icon: const Icon(
                    Icons.flag,
                    // color: Color(0xFFFD2B2B),
                  ))
              : e.columnName == 'check'
                  ? CustomCheckbox(
                      onPress: onChoose,
                      index: index,
                      isChecked: importOrder[index],
                    )
                  : Text(
                      e.columnName == 'STT'
                          ? (i++).toString()
                          : e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ));
    }).toList());
  }
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
