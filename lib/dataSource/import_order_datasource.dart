import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/screen/check_import_order.dart';
import 'package:serenity/screen/edit_import_order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/importOrder/import_order_bloc.dart';
import '../model/import_order.dart';
import '../screen/create_import_order.dart';
import '../screen/payment_voucher.dart';

class ImportOrderDataSource extends DataGridSource {
  BuildContext? context;
  Function? onPress;
  final List<ImportOrder> importOrders;

  /// Creates the employee data source class with required details.
  ImportOrderDataSource({
    required List<ImportOrder> this.importOrders,
    required BuildContext this.context,
    required Function this.onPress,
  }) {
    // importOrdersTemp = importOrders;
    _employeeData = importOrders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<ImportOrder>(columnName: 'STT', value: e),
              DataGridCell<String>(columnName: 'name', value: e.nameA),
              DataGridCell<String>(
                  columnName: 'date',
                  value:
                      '${e.dateCreated!.toDate().day}/${e.dateCreated!.toDate().month}/${e.dateCreated!.toDate().year}'),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(
                  columnName: 'price', value: e.totalPrice!.toString()),
              DataGridCell<String>(columnName: 'note', value: e.note),
              DataGridCell<ImportOrder>(columnName: 'button', value: e),
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
      Color backgroundColor = Colors.white, textColor = Colors.black;
      bool isCanceled = false;
      bool isCompleted = false;
      int index = 0;
      if (e.columnName == 'STT') {
        index = importOrders.indexOf(e.value);
      }
      if (e.columnName == 'button') {
        if (e.value.status == 'canceled') {
          isCanceled = true;
        } else if (e.value.status == 'completed') {
          isCompleted = true;
        }
      }
      if (e.columnName == 'status') {
        switch (e.value) {
          case 'pending':
            backgroundColor = const Color(0xFFFEFFCB);
            textColor = const Color(0xFFEDB014);
            break;
          case 'completed':
            backgroundColor = const Color(0xFFDCFBD7);
            textColor = const Color(0xFF5CB16F);

            break;
          case 'canceled':
            backgroundColor = const Color(0xFFFFEFEF);
            textColor = const Color(0xFFFD2B2B);

            break;
          case 'trouble':
            backgroundColor = const Color(0xFFFEFFCB);
            textColor = const Color(0xFFEDB014);
            break;
        }
      }
      return Container(
          alignment: Alignment.centerLeft,
          // height: 100,
          // padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: const Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.black,
                    ),
                    customItemsHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                      if (!(isCanceled || isCompleted)) 8,
                      if (!(isCanceled || isCompleted))
                        ...List<double>.filled(
                            MenuItems.secondItems.length, 48),
                    ],
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      if (!(isCanceled || isCompleted))
                        const DropdownMenuItem<Divider>(
                            enabled: false, child: Divider()),
                      if (!(isCanceled || isCompleted))
                        ...MenuItems.secondItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      print(importOrders
                          .where((element) =>
                              element.idImportOrder == e.value.idImportOrder)
                          .first);
                      MenuItems.onChanged(
                        context!,
                        value as MenuItem,
                        onPress!,
                        importOrders,
                        e.value,
                      );
                    },
                    itemHeight: 48,
                    itemPadding: const EdgeInsets.only(left: 16, right: 16),
                    dropdownWidth: 210,
                    dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    offset: const Offset(0, 8),
                  ),
                )
              : e.columnName == 'status'
                  ? Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Center(
                        child: Text(
                          e.value,
                          style: TextStyle(
                              fontSize: 20,
                              color: textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  : Text(
                      e.columnName == 'STT'
                          ? (index).toString()
                          : e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
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
  static const List<MenuItem> firstItems = [edit, print];
  static const List<MenuItem> secondItems = [check, paymentVoucher];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const print = MenuItem(text: 'Print', icon: Icons.print);
  static const check = MenuItem(text: 'Check', icon: Icons.checklist);
  static const paymentVoucher =
      MenuItem(text: 'Payment voucher', icon: Icons.edit_note);

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
      List<ImportOrder> importOrders, ImportOrder order) {
    switch (item) {
      case MenuItems.edit:
        // ImportOrder tempOrder = importOrders
        //     .where(
        //       (element) => element.idImportOrder == order.idImportOrder,
        //     )
        //     .first;
        // debugPrint(tempOrder.listProduct.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditImportOrder(
                  key: UniqueKey(),
                  importOrder: order,
                  listProduct: [...order.listProduct!]),
            ));
        break;
      case MenuItems.check:
        // List<ProductImportOrder> productImportOrder = importOrders
        //     .where((element) => element.idImportOrder == order.idImportOrder)
        //     .first
        //     .listProduct!;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckImportOrder(importOrder: order),
            ));
        //Do something
        break;
      case MenuItems.print:
        //Do something
        break;
      case MenuItems.paymentVoucher:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentVoucher(),
            ));
        break;
    }
  }
}
