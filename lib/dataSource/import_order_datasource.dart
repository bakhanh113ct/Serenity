import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/screen/check_import_order.dart';
import 'package:serenity/screen/edit_import_order.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
                      // print(importOrders
                      //     .where((element) =>
                      //         element.idImportOrder == e.value.idImportOrder)
                      //     .first);
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

  static const edit = MenuItem(text: 'View/Edit', icon: Icons.edit);
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
        Print(order);
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

  static void Print(ImportOrder order) async {
    final pdf = pw.Document();
    final ttf = await fontFromAssetBundle('assets/fonts/Poppins-Regular.ttf');
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Column(children: [
                  pw.Text("SOCIALIST REPUBLIC OF VIETNAM",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Independence - Freedom - Happiness'),
                  pw.Text('****************************\n\n'),
                  pw.Text('CONTRACT FOR SALE OF GOODS\n\n',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ])),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          'Pursuant to the civil code No. 91/2015/QH13 dated November 24, 2015'),
                      pw.Text(
                          'Pursuant to Commercial law No. 36/2005/QH11, passed by the national assembly on January 01st, 2006'),
                      pw.Text(
                          'Pursuant to offer (offer or agreement of both parties).'),
                      pw.Text(
                          'Today, Date ${DateTime.now().day} Month ${DateTime.now().month} Year ${DateTime.now().year}'),
                      pw.Text('At place: ....... \n\n'),
                      pw.Text('We include:'),
                      pw.Text('Party A (hereinafter referred to as "Seller")',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name of enterprise: ${order.nameA}'),
                      pw.Text('The head office address: ${order.addressA}'),
                      pw.Text('Number phone: ${order.phoneA}'),
                      pw.Text('Bank account No: ${order.bankA}'),
                      pw.Text('Opening at bank: ${order.atBankA}'),
                      pw.Text('Authorized person: ${order.authorizedPersonA}'),
                      pw.Text('Position: ${order.positionA}'),
                      pw.Text(
                          'The letter of authorization (If the authorized person signs on behalf of the director) No: ${order.noAuthorizationA}'),
                      pw.Text(
                          'Date: ${order.dateAuthorizationA!.toDate().day} / ${order.dateAuthorizationA!.toDate().month} / ${order.dateAuthorizationA!.toDate().year}\n\n'),
                      pw.Text('Party B (hereinafter referred to as "Buyer")',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name of enterprise: ${order.nameB}'),
                      pw.Text('The head office address: ${order.addressB}'),
                      pw.Text('Number phone: ${order.phoneB}'),
                      pw.Text('Bank account No: ${order.bankB}'),
                      pw.Text('Opening at bank: ${order.atBankB}'),
                      pw.Text('Authorized person: ${order.authorizedPersonB}'),
                      pw.Text('Position: ${order.positionB}'),
                      pw.Text(
                          'The letter of authorization (If the authorized person signs on behalf of the director) No: ${order.noAuthorizationB}'),
                      pw.Text(
                          'Date: ${order.dateAuthorizationB!.toDate().day} / ${order.dateAuthorizationB!.toDate().month} / ${order.dateAuthorizationB!.toDate().year}\n\n'),
                      pw.Text(
                          'Both parties agreed to the conclusion of contract with the contents as follows:'),
                      pw.Text('RECITALS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('1. Production Expansion.'),
                      pw.Text(
                          'a. Buyer is expanding its production facilities.'),
                      pw.Text(
                          'b. The expansion plan subdivides into three phases which come on line:'),
                      pw.Text(
                          'c. To commence production in a phase of new construction, Buyer must satisfy the following conditions:'),
                      pw.Text('- Obtain a Certificate of Occupancy, and'),
                      pw.Text('- Receive authorization to manufacture.'),
                      pw.Text(
                          'd. To qualify for the foregoing conditions, Buyer must pass a fire safety inspection, which requires it adequately equip its machinery with slings and hoists.\n\n'),
                    ])),
          ]); // Center
        })); // Page
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('TERMS',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('1. Agreement of Sale.',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(
                    'Seller agrees to sell and Buyer agrees to buy 200 units of the Model X 47 Mechanical Sling for \$1,000 per unit. ("Unit" - each individual Model X 47 Mechanical Sling).\n\n'),
                pw.Text('2. Payment'),
                pw.Text(
                    'Payment shall occur upon delivery for the price stated in section 1.\nPayment shall occur at Seller\'s production plant on 123 Broad Street, Lexington, KY 40502.\n\n'),
                pw.Text('3. Delivery and Acceptance.'),
                pw.Text(
                    'a. Delivery shall occur at Seller\'s production plant.'),
                pw.Text('b. Delivery shall be in three installments.'),
                pw.Text('c. Installments one and two shall be in fifty units.'),
                pw.Text(
                    'd. The third installment shall be in one-hundred units.\n\n'),
                pw.Text('4. Loading & Transportation.'),
                pw.Text(
                    'Buyer agrees to collect, load, and transport the goods at its expense.\n\n'),
                pw.SizedBox(
                    height: 200,
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Column(
                            children: [
                              pw.Text('Representative A Position'),
                              pw.Text(
                                '${order.positionA}',
                              ),
                              pw.Text('Sign'),
                            ],
                          ),
                          pw.Column(
                            children: [
                              pw.Text('Representative B Position'),
                              pw.Text(
                                '${order.positionA}',
                              ),
                              pw.Text('Sign'),
                            ],
                          )
                        ]))
              ]);
        }));
    final output = await getTemporaryDirectory();
    debugPrint(output.path);
    // final file = File('${output.path}/example.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
