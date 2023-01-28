import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/customer.dart';
import '../../model/order.dart';
import '../../model/product_cart.dart';
import '../../model/voucher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../repository/payment.dart';

class OrderRepository {
  final orders = FirebaseFirestore.instance.collection("Order");
  final detailOrders = FirebaseFirestore.instance.collection("DetailOrder");
  getOrder() async {
    List<MyOrder> listOrder = [];
    await orders.get().then((value) {
      listOrder
          .addAll(value.docs.map((e) => MyOrder.fromJson(e.data())).toList());
    });
    return listOrder;
  }

  createOrder(
      Customer customer,
      Voucher? voucher,
      List<ProductCart> listProductCart,
      double total,
      double discount,
      double item, String methodPayment) async {
    String idOrder = "";
    double profit=0;
    listProductCart.forEach((element) { 
      profit+=(double.parse(element.product!.price!)-double.parse(element.product!.historicalCost!))*element.amount!;
    });
    profit-=discount;
    await orders.add({
      "idCustomer": customer.idCustomer,
      "idVoucher": voucher==null?"":voucher.idVoucher,
      "idUser": FirebaseAuth.instance.currentUser!.uid,
      "nameCustomer": customer.name,
      "phone":customer.phone,
      "dateCreated": DateTime.now(),
      "status": "Pending",
      "price": total.toString(),
      "profit":profit.toString()
    }).then((value) {
      orders.doc(value.id).update({"idOrder": value.id});
      idOrder = value.id;
    });
    await createPdf(listProductCart, item, discount, total, idOrder);
    listProductCart.forEach((element) {
      detailOrders.add({
        "idOrder": idOrder,
        "idProduct": element.product!.idProduct,
        "name":element.product!.name,
        "amount": element.amount.toString(),
        "price":(double.tryParse(element.product!.price.toString())!*element.amount!).toString()
      }).then((value) {
        detailOrders.doc(value.id).update({"idDetailOrder": value.id});
      });
    });
    if(methodPayment=="ZaloPay"){
      final createOrderResponse= await createOrderZaloPay(total);
    if(await canLaunchUrl(Uri.parse(createOrderResponse!.orderurl))){
      await launchUrl(Uri.parse(createOrderResponse.orderurl));
    }
    }
    
  }

   Future<void> updateOrder(MyOrder id) async {
    await orders.doc(id.idOrder).update(id.toJson());
  }

Future<MyOrder> getOrderById(String idOrder) async {
    MyOrder result = MyOrder();
    await orders
        .where('idOrder', isEqualTo: idOrder)
        .get()
        .then((value) {
      result = MyOrder.fromJson(value.docs.first.data());
    });
    return result;
  }


  Future<void> createPdf(List<ProductCart> listProductCart, double item,
      double discount, double total, String idOrder) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final image = imageFromAssetBundle('assets/images/logo.png');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (pw.Context context) => pw.Column(children: [
          pw.Text('SERENITY COMPANY', style: pw.TextStyle(font: ttf)),
          pw.Text('Khu pho 6, P.Linh Trung, Tp.Thu Duc, Tp.Ho Chi Minh.',
              style: pw.TextStyle(font: ttf)),
          pw.SizedBox(height: 20),
          pw.Center(
              child: Text('SALES INVOICE', style: pw.TextStyle(font: ttf))),
          pw.Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(DateFormat('dd-MM-yyyy').format(DateTime.now())),
            Text(DateFormat('Hm').format(DateTime.now())),
          ]),
          pw.SizedBox(height: 8),
          buildInvoice(listProductCart, ttf),
          pw.Divider(height: 1),
          pw.SizedBox(height: 4),
          pw.Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Items"),
            Text(NumberFormat.currency(locale: "vi-VN", symbol: "").format(item)),
          ]),
          pw.SizedBox(height: 4),
          pw.Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Discount"),
            Text(NumberFormat.currency(locale: "vi-VN", symbol: "").format(discount)),
          ]),
          pw.SizedBox(height: 4),
          pw.Divider(height: 1),
          pw.Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
          child: pw.Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total"),
            Text(NumberFormat.currency(locale: "vi-VN", symbol: "").format(total)),
          ]),),
      
        ]),
      ),
    );

    // final output = await getExternalStorageDirectory();
    // final file = File("${output!.path}/example.pdf");
    // print(output.path);
    // await file.writeAsBytes(await pdf.save());
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdf.save());
        // await Printing.sharePdf(bytes: await pdf.save(), filename: 'my-document.pdf');
        // final output = await getTemporaryDirectory();
   
    // final file = File('${output.path}/example.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  pw.Table buildInvoice(List<ProductCart> listProductCart, Font ttf) {
    final headers = ["Product", "Quantity", "UnitPrice", "Total"];
    final data = listProductCart.map((e) {
      final total = double.parse(e.product!.price!) * e.amount!;
      return [
        e.product!.name.toString(),
        e.amount.toString(),
        e.product!.price.toString(),
        NumberFormat.currency(locale: "vi-VN", symbol: "").format(total)
      ];
    }).toList();
    return pw.Table.fromTextArray(
      cellStyle: pw.TextStyle(font: ttf),
      headerStyle: pw.TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      headers: headers,
      data: data,
      border: null,
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.centerLeft,
        3: Alignment.centerRight,
      },
    );
  }
}
