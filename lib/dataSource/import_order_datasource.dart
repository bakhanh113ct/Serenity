import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class ImportOrderDataSource extends DataGridSource {
  int i = 0;
  BuildContext? context;

  /// Creates the employee data source class with required details.
  ImportOrderDataSource(
      {required List<ImportOrder> employeeData,
      required BuildContext context}) {
    this.context = context;
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'STT', value: e.idImportOrder),
              DataGridCell<String>(columnName: 'name', value: e.nameA),
              DataGridCell<String>(
                  columnName: 'date',
                  value: e.dateCreated!.toDate().day.toString() +
                      '/' +
                      e.dateCreated!.toDate().month.toString() +
                      '/' +
                      e.dateCreated!.toDate().year.toString()),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<double>(
                  columnName: 'price', value: e.totalPrice!.toDouble()),
              DataGridCell<String>(columnName: 'note', value: e.note),
              DataGridCell<String>(columnName: 'button', value: e.note),
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
                      MenuItems.onChanged(context!, value as MenuItem);
                    },
                    itemHeight: 48,
                    itemPadding: const EdgeInsets.only(left: 16, right: 16),
                    dropdownWidth: 160,
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
                        'Completed',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5CB16F),
                            fontWeight: FontWeight.w500),
                      ),
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
  static const List<MenuItem> firstItems = [home, share, check];
  static const List<MenuItem> secondItems = [cancel];

  static const home = MenuItem(text: 'Edit', icon: Icons.edit);
  static const share = MenuItem(text: 'Print', icon: Icons.print);
  static const check = MenuItem(text: 'Check', icon: Icons.checklist);
  static const cancel = MenuItem(text: 'Close', icon: Icons.cancel);

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

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.check:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.cancel:
        //Do something
        break;
    }
  }
}
