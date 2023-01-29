import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/model/payment_voucher.dart';
import 'package:serenity/widget/input_import_voucher.dart';

import 'package:pdf/widgets.dart' as pw;

class PaymentVoucherScreen extends StatefulWidget {
  const PaymentVoucherScreen(
      {super.key, required this.importOrder, required this.paymentVoucher});
  final ImportOrder importOrder;
  final PaymentVoucher? paymentVoucher;
  @override
  State<PaymentVoucherScreen> createState() => _PaymentVoucherScreenState();
}

class _PaymentVoucherScreenState extends State<PaymentVoucherScreen> {
  late TextEditingController dateController;
  late TextEditingController receiverNameController;
  late TextEditingController receiverAddressController;
  late TextEditingController totalController;
  late TextEditingController inWordsController;
  late TextEditingController noteController;
  late TextEditingController descriptionController;
  late TextEditingController chiefAccountantController;
  late TextEditingController cashierController;
  late TextEditingController voteMakerController;
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dateController = TextEditingController();
    receiverNameController = TextEditingController();
    receiverAddressController = TextEditingController();
    totalController = TextEditingController();
    inWordsController = TextEditingController();
    noteController = TextEditingController();
    descriptionController = TextEditingController();
    chiefAccountantController = TextEditingController();
    cashierController = TextEditingController();
    voteMakerController = TextEditingController();
    // selectedDate = DateTime.now();
    dateController.text =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

    //check null
    if (widget.paymentVoucher != null) {
      dateController.text =
          '${widget.paymentVoucher!.date!.toDate().day}/${widget.paymentVoucher!.date!.toDate().month}/${widget.paymentVoucher!.date!.toDate().year}';
      receiverNameController.text = widget.paymentVoucher!.receiver!;
      receiverAddressController.text = widget.paymentVoucher!.receiverAddress!;
      totalController.text = widget.paymentVoucher!.totalAmount!;
      inWordsController.text = widget.paymentVoucher!.inWord!;
      descriptionController.text = widget.paymentVoucher!.description!;
      chiefAccountantController.text = widget.paymentVoucher!.chiefAccountant!;
      cashierController.text = widget.paymentVoucher!.cashier!;
      voteMakerController.text = widget.paymentVoucher!.voteMaker!;
    }
    super.initState();
  }

  _selectDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate!,
    //   firstDate: DateTime(2023),
    //   lastDate: DateTime(2024),
    // );
    // if (picked != null) {
    //   setState(() {
    //     selectedDate = picked;
    //     dateController.text = '${picked.day}/${picked.month}/${picked.year}';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Payment Voucher',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                color: Color(0xFF226B3F),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFEBFDF2),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFEBFDF2),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              //   const SizedBox(
              //   height: 16,
              // ),
              // const Text(
              //   'Check Order',
              //   style: TextStyle(
              //       fontFamily: 'Poppins',
              //       fontSize: 30,
              //       color: Color(0xFF226B3F),
              //       fontWeight: FontWeight.w600),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              Text(
                'ID Order: ${widget.importOrder.idImportOrder}',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    // color: Color(0xFF226B3F),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Status: ${widget.importOrder.status}',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    // color: Color(0xFF226B3F),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.9,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: InputImportVoucher(
                                        text: 'Date',
                                        controller: dateController,
                                        icon: Icons.calendar_month,
                                        onPress: () {
                                          _selectDate(context);
                                        },
                                        textInputType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'Total amount',
                                            icon: Icons.abc,
                                            controller: totalController,
                                            onPress: () {},
                                            textInputType:
                                                TextInputType.number)),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'Chief accountant',
                                            icon: Icons.abc,
                                            controller:
                                                chiefAccountantController,
                                            onPress: () {},
                                            textInputType: TextInputType.text)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InputImportVoucher(
                                        text: 'Receiver',
                                        controller: receiverNameController,
                                        icon: Icons.abc,
                                        onPress: () {},
                                        textInputType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'In words',
                                            icon: Icons.abc,
                                            controller: inWordsController,
                                            onPress: () {},
                                            textInputType: TextInputType.text)),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'Cashier',
                                            icon: Icons.abc,
                                            controller: cashierController,
                                            onPress: () {},
                                            textInputType: TextInputType.text)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: InputImportVoucher(
                                        text: 'Receiver Address',
                                        controller: receiverAddressController,
                                        icon: Icons.abc,
                                        onPress: () {},
                                        textInputType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'For',
                                            icon: Icons.abc,
                                            controller: descriptionController,
                                            onPress: () {},
                                            textInputType: TextInputType.text)),
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InputImportVoucher(
                                            text: 'Vote maker',
                                            icon: Icons.abc,
                                            controller: voteMakerController,
                                            onPress: () {},
                                            textInputType: TextInputType.text)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  // maximumSize:
                                  //     MaterialStateProperty.all(const Size(110, 60)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 32)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF226B3F))),
                              child: const Text(
                                'Cancel ',
                                style: TextStyle(fontSize: 20),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  printPaymentVoucher();
                                }
                              },
                              style: ButtonStyle(
                                  // maximumSize:
                                  //     MaterialStateProperty.all(const Size(110, 60)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 32)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF226B3F))),
                              child: const Text(
                                'Print ',
                                style: TextStyle(fontSize: 20),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  CollectionReference doc = FirebaseFirestore
                                      .instance
                                      .collection('PaymentVoucher');
                                  if (widget.paymentVoucher == null) {
                                    doc.add({
                                      "idUser": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "idImportOrder":
                                          widget.importOrder.idImportOrder,
                                      "date": DateTime.now(),
                                      "receiver": receiverNameController.text,
                                      "receiverAddress":
                                          receiverAddressController.text,
                                      "totalAmount": totalController.text,
                                      "inWord": inWordsController.text,
                                      "description": descriptionController.text,
                                      "chiefAccountant":
                                          chiefAccountantController.text,
                                      "cashier": cashierController.text,
                                      "voteMaker": voteMakerController.text,
                                    }).then((value) => doc.doc(value.id).update(
                                        {"idPaymentVoucher": value.id}));
                                  } else {
                                    print('ipdate');
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  // maximumSize:
                                  //     MaterialStateProperty.all(const Size(110, 60)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 32)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF226B3F))),
                              child: const Text(
                                'Save ',
                                style: TextStyle(fontSize: 20),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void printPaymentVoucher() async {
    final pdf = pw.Document();
    final ttf = await fontFromAssetBundle('assets/fonts/Poppins-Regular.ttf');
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Company: Serenity'),
                        pw.Text('Address: 123/21 Binh Duong'),
                      ]),
                  pw.Column(
                      // crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('Form: 01/TT'),
                        pw.Text('According to Circular No.200/2014/TT-BTC'),
                        pw.Text('Dated december 22nd 2014 of the Ministry of'),
                        pw.Text('Finance'),
                      ])
                ]),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text('PAYMENT\n\n',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          'Date: ${dateController.text}....................................................................'),
                      pw.Text(
                          'Receiver: ${receiverNameController.text}..............................................................'),
                      pw.Text(
                          'Address: ${receiverAddressController.text}...............................................................'),
                      pw.Text(
                          'For: ${descriptionController.text}...............................................................'),
                      pw.Text(
                          'Amount: ${totalController.text}................................................................'),
                      pw.Text(
                          'In Words: ${inWordsController.text}...................................................................'),
                      pw.Text(
                          'Enclosure: ...................................................................document(s)\n\n\n'),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Column(children: [
                              pw.Text('Chief Accountant\n\n\n\n\n\n\n\n\n'),
                              pw.Text(chiefAccountantController.text)
                            ]),
                            pw.Column(children: [
                              pw.Text('Cashier\n\n\n\n\n\n\n\n\n'),
                              pw.Text(cashierController.text)
                            ]),
                            pw.Column(children: [
                              pw.Text('Vote Maker\n\n\n\n\n\n\n\n\n'),
                              pw.Text(voteMakerController.text),
                            ]),
                            pw.Column(children: [
                              pw.Text('Receiver\n\n\n\n\n\n\n\n\n'),
                              pw.Text(receiverNameController.text),
                            ]),
                          ]),
                      pw.Text(
                          '\n\nReceived the amount (in words): ${totalController.text}.............................................'),
                    ])),
          ]);
        }));
    final output = await getTemporaryDirectory();
    debugPrint(output.path);
    // final file = File('${output.path}/example.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
