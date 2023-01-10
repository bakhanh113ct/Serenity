import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/screen/check_import_order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';
import '../screen/create_import_order.dart';
import '../screen/payment_voucher.dart';

class ImportOrderDataSource extends DataGridSource {
  BuildContext? context;
  Function? onPress;
  List<ImportOrder> importOrders = [];
  // int i = 0;

  /// Creates the employee data source class with required details.
  ImportOrderDataSource(
      {required List<ImportOrder> employeeData,
      required BuildContext this.context,
      required Function this.onPress}) {
    importOrders = employeeData;
    _employeeData = employeeData
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
              DataGridCell<String>(
                  columnName: 'button', value: e.idImportOrder),
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
      int i = 0;
      if (e.columnName == 'STT') {
        i = importOrders.indexOf(e.value);
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
                      8,
                      ...List<double>.filled(MenuItems.secondItems.length, 48),
                    ],
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      const DropdownMenuItem<Divider>(
                          enabled: false, child: Divider()),
                      ...MenuItems.secondItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
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
                      decoration: BoxDecoration(
                          color: Color(0xFFDCFBD7),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        e.value,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5CB16F),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : Text(
                      e.columnName == 'STT'
                          ? (i).toString()
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
  static const List<MenuItem> firstItems = [edit, print, check];
  static const List<MenuItem> secondItems = [paymentVoucher];

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
      List<ImportOrder> importOrders, String id) {
    switch (item) {
      case MenuItems.edit:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateImportOrder(),
            ));
        break;
      case MenuItems.check:
        debugPrint(id);
        List<ProductImportOrder> productImportOrder = importOrders
            .where((element) => element.idImportOrder == id)
            .first
            .listProduct!;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CheckImportOrder(products: productImportOrder),
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
