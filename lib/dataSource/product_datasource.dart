import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/User.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/import_order.dart';

class ProductDataSource extends DataGridSource {
  int i = 1;
  Function? onPress;
  BuildContext? context;

  /// Creates the employee data source class with required details.
  ProductDataSource(
      {required List<ProductImportOrder> productData,
      required Function this.onPress,
      required BuildContext this.context}) {
    _employeeData = productData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'STT', value: e.product!.idProduct),
              DataGridCell<String>(columnName: 'name', value: e.product!.name),
              DataGridCell<String>(
                  columnName: 'price', value: e.product!.price),
              DataGridCell<int>(columnName: 'amount', value: e.amount!),
              DataGridCell<Object>(columnName: 'totalPrice', value: {
                "amount": e.amount!,
                "price": int.parse(e.product!.price!)
              }),
              DataGridCell<String>(columnName: 'note', value: e.note),
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
      return Container(
          alignment: Alignment.centerLeft,
          // height: 100,
          // padding: EdgeInsets.all(8.0),
          child: e.columnName == 'button'
              ? DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    alignment: AlignmentDirectional.centerStart,
                    icon: const Icon(Icons.settings),
                    customButton: const Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.black,
                    ),
                    customItemsHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                      // 8,
                      // ...List<double>.filled(MenuItems.secondItems.length, 48),
                    ],
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      // const DropdownMenuItem<Divider>(
                      //     enabled: false, child: Divider()),
                      // ...MenuItems.secondItems.map(
                      //   (item) => DropdownMenuItem<MenuItem>(
                      //     value: item,
                      //     child: MenuItems.buildItem(item),
                      //   ),
                      // ),
                    ],
                    onChanged: (valueChange) {
                      MenuItems.onChanged(context!, valueChange as MenuItem,
                          onPress!, e.value, i);
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
                      decoration: const BoxDecoration(
                          color: Color(0xFFDCFBD7),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        'complete',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF5CB16F),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : e.columnName == 'totalPrice'
                      ? Text(
                          (e.value["amount"] * e.value["price"]).toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
  static const List<MenuItem> secondItems = [importVoucher];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const remove = MenuItem(text: 'Remove', icon: Icons.delete);
  static const check = MenuItem(text: 'Check', icon: Icons.checklist);
  static const importVoucher =
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
      ProductImportOrder product, int index) {
    switch (item) {
      case MenuItems.edit:
        onPress(product.product!.name, product, index);
        break;
      case MenuItems.remove:
        onPress(product.product!.name, null, index);
        break;
      case MenuItems.importVoucher:
        //Do something
        break;
    }
  }
}
