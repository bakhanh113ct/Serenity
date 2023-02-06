import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocOrder/order_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:serenity/model/product.dart';
import '../../bloc/blocUser/user_repository.dart';
import '../../model/delivery_receipt.dart';
import 'delivery_receipt_dialog.dart';

enum ActionOptions { view, print, close }

class DeliveryReceiptMoreButton extends StatefulWidget {
  const DeliveryReceiptMoreButton({Key? key, required this.deliveryReceipt})
      : super(key: key);
  final DeliveryReceipt deliveryReceipt;
  @override
  State<DeliveryReceiptMoreButton> createState() =>
      _DeliveryReceiptMoreButtonState();
}

class _DeliveryReceiptMoreButtonState extends State<DeliveryReceiptMoreButton> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  onView() async {
    var order =
        await OrderRepository().getOrderById(widget.deliveryReceipt.idOrder!);
    showDialog(
      context: context,
      builder: (context) {
        return DeliveryReceiptEditDialog(
          idDeliveryReceipt: widget.deliveryReceipt.idDeliveryReceipt!,
          title: 'View DeliveryReceipt',
          isEdit: false,
          order: order,
        );
      },
    );
  }

   onPrint() async {
    Print(widget.deliveryReceipt);
  }

  static void Print(DeliveryReceipt dc) async {
    final pdf = pw.Document();
    final ttf = await fontFromAssetBundle('assets/fonts/Poppins-Regular.ttf');
    var staff = await UserRepository().getUserByIdUser(dc.idStaff!);

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
                  pw.Text('DELIVERY RECEIPT\n\n',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Align(
                    alignment: pw.Alignment.topRight,
                    child: pw.Text(
                        'Today, Date ${DateTime.now().day} Month ${DateTime.now().month} Year ${DateTime.now().year}'),
                  ),
                ])),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('INFORMATION',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Id delivery receipt: ${dc.idDeliveryReceipt}'),
                      pw.Text(
                          'The time to make delivery receipt: ${DateFormat('dd-MM-yyyy hh:mm:ss aa').format(dc.dateCreated!.toDate())}'),
                      pw.Text('At place: Serenity Store'),
                      pw.Text('REPRESENTATION',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name of staff: ${staff.fullName}'),
                      pw.Text('Number phone: ${staff.phone}'),
                      pw.Text('Email: ${staff.email}'),
                      pw.Text('RECITALS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('1. Export product.'),
                      pw.Text('Id of order: ${dc.idOrder}'),
                      pw.Text('Name of customer: ${dc.nameCustomer}'),
                      pw.Text('List products: '),
                      buildProduct(dc.listProducts!, ttf),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text('Total Price: ${dc.totalMoney}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ])),
            pw.SizedBox(
                height: 200,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text('Staff'),
                          pw.Text(
                            '${staff.fullName}',
                          ),
                        ],
                      )
                    ]))
          ]); // Center
        })); // Page

    final output = await getTemporaryDirectory();
    debugPrint(output.path);
    // final file = File('${output.path}/example.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  static pw.Table buildProduct(
      List<Product> listProduct, pw.Font ttf) {
    final headers = ["Product", "Quantity", "UnitPrice", "Total"];
    final data = listProduct.map((e) {
      final total = double.parse(e.price!) * int.parse(e.amount!);
      return [
        e.name.toString(),
        e.amount.toString(),
        e.price.toString(),
        NumberFormat.currency(locale: "vi-VN", symbol: "").format(total)
      ];
    }).toList();
    return pw.Table.fromTextArray(
      cellStyle: pw.TextStyle(font: ttf),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      headers: headers,
      data: data,
      border: null,
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
      },
    );
  }

  onClose() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Container(
            alignment: Alignment.centerLeft,
            child: PopupMenuButton<ActionOptions>(
                onSelected: (ActionOptions value) {
                  if (value == ActionOptions.view) {
                    onView();
                    return;
                  }
                  if (value == ActionOptions.print) {
                    onPrint();
                    return;
                  }
                  if (value == ActionOptions.close) {
                    onClose();
                    return;
                  }
                },
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: ActionOptions.view,
                        child: ListTile(
                          leading:
                              Icon(Icons.view_comfortable, color: Colors.black),
                          title: Text('View'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: ActionOptions.print,
                        child: ListTile(
                          leading: Icon(
                            Icons.print,
                            color: Colors.black,
                          ),
                          title: Text('Print'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: ActionOptions.close,
                        child: ListTile(
                          leading:
                              Icon(Icons.close_rounded, color: Colors.black),
                          title: Text('Close'),
                        ),
                      ),
                    ]),
          );
  }
}
