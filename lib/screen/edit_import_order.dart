import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/importOrder/import_order_bloc.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/modal_add_product_import_order.dart';
import 'package:serenity/widget/modal_edit_product_import_order.dart';
import 'package:serenity/widget/table_product.dart';
import '../widget/table_import_order.dart';

class EditImportOrder extends StatefulWidget {
  const EditImportOrder(
      {super.key, required this.importOrder, required this.listProduct});
  final ImportOrder importOrder;
  final List<ProductImportOrder> listProduct;
  @override
  State<EditImportOrder> createState() => _EditImportOrderState();
}

class _EditImportOrderState extends State<EditImportOrder> {
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context, String party) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        if (party == 'A') {
          dateA = picked;
          dateLetterAuthorizationAControler.text =
              '${picked.day}/${picked.month}/${picked.year}';
        } else {
          dateLetterAuthorizationBControler.text =
              '${picked.day}/${picked.month}/${picked.year}';
          dateB = picked;
        }
      });
  }

  late DateTime? dateA, dateB, dateCreated;
  TextEditingController enterpriseNameAControler = TextEditingController();
  TextEditingController addressAControler = TextEditingController();
  TextEditingController phoneAControler = TextEditingController();
  TextEditingController bankAControler = TextEditingController();
  TextEditingController bankOpenAControler = TextEditingController();
  TextEditingController nameAuthorizedAControler = TextEditingController();
  TextEditingController positionAuthorizedAControler = TextEditingController();
  TextEditingController noLetterAuthorizationAControler =
      TextEditingController();
  TextEditingController dateLetterAuthorizationAControler =
      TextEditingController();

  TextEditingController enterpriseNameBControler = TextEditingController();
  TextEditingController addressBControler = TextEditingController();
  TextEditingController phoneBControler = TextEditingController();
  TextEditingController bankBControler = TextEditingController();
  TextEditingController bankOpenBControler = TextEditingController();
  TextEditingController nameAuthorizedBControler = TextEditingController();
  TextEditingController positionAuthorizedBControler = TextEditingController();
  TextEditingController noLetterAuthorizationBControler =
      TextEditingController();
  TextEditingController dateLetterAuthorizationBControler =
      TextEditingController();

  TextEditingController pursuantControler = TextEditingController();
  TextEditingController dateCreatedControler = TextEditingController();
  TextEditingController placeControler = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late List<TextEditingController> listController;
  late List<ProductImportOrder> products;
  late List<ProductImportOrder> productsOld;

  bool readOnly = false;
  @override
  void initState() {
    // List<ProductImportOrder> products = <ProductImportOrder>[];
    // productsOld = widget.importOrder.listProduct!;
    products = widget.listProduct;
    if (widget.importOrder.status == 'completed' ||
        widget.importOrder.status == 'checked' ||
        widget.importOrder.status == 'canceled') readOnly = true;

    enterpriseNameAControler.text = widget.importOrder.nameA!;
    addressAControler.text = widget.importOrder.addressA!;
    phoneAControler.text = widget.importOrder.phoneA!;
    bankAControler.text = widget.importOrder.bankA!;
    bankOpenAControler.text = widget.importOrder.atBankB!;
    nameAuthorizedAControler.text = widget.importOrder.authorizedPersonA!;
    positionAuthorizedAControler.text = widget.importOrder.positionA!;
    noLetterAuthorizationAControler.text = widget.importOrder.noAuthorizationA!;
    dateLetterAuthorizationAControler.text =
        ('${widget.importOrder.dateAuthorizationA!.toDate().day}/${widget.importOrder.dateAuthorizationA!.toDate().month}/${widget.importOrder.dateAuthorizationA!.toDate().year}');

    enterpriseNameBControler.text = widget.importOrder.nameB!;
    addressBControler.text = widget.importOrder.addressB!;
    phoneBControler.text = widget.importOrder.phoneB!;
    bankBControler.text = widget.importOrder.bankB!;
    bankOpenBControler.text = widget.importOrder.atBankB!;
    nameAuthorizedBControler.text = widget.importOrder.authorizedPersonB!;
    positionAuthorizedBControler.text = widget.importOrder.positionB!;
    noLetterAuthorizationBControler.text = widget.importOrder.noAuthorizationB!;
    dateLetterAuthorizationBControler.text =
        ('${widget.importOrder.dateAuthorizationB!.toDate().day}/${widget.importOrder.dateAuthorizationB!.toDate().month}/${widget.importOrder.dateAuthorizationB!.toDate().year}');

    pursuantControler.text = widget.importOrder.pursuant!;
    dateCreatedControler.text =
        ('${widget.importOrder.dateCreated!.toDate().day}/${widget.importOrder.dateCreated!.toDate().month}/${widget.importOrder.dateCreated!.toDate().year}');
    placeControler.text = widget.importOrder.atPlace!;
    noteController.text = widget.importOrder.note!;

    dateA = widget.importOrder.dateAuthorizationA!.toDate();
    dateB = widget.importOrder.dateAuthorizationB!.toDate();
    listController = [
      enterpriseNameAControler,
      addressAControler,
      phoneAControler,
      bankAControler,
      bankOpenAControler,
      nameAuthorizedAControler,
      positionAuthorizedAControler,
      noLetterAuthorizationAControler,
      dateLetterAuthorizationAControler,
      enterpriseNameBControler,
      addressBControler,
      phoneBControler,
      bankBControler,
      bankOpenBControler,
      nameAuthorizedBControler,
      positionAuthorizedBControler,
      noLetterAuthorizationBControler,
      dateLetterAuthorizationBControler,
      pursuantControler,
      dateCreatedControler,
      placeControler
    ];
    // dateCreatedControler.text =
    //     '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    dateCreated = widget.importOrder.dateCreated!.toDate();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool isValidate = false;

  String calculateTotal() {
    int total = 0;

    final format = NumberFormat("###,###.###", "tr_TR");
    products.forEach((element) {
      total += (element.amount!) * int.parse(element.product!.price!);
    });
    return format.format(total);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEBFDF2),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Edit import order',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(children: [
                // const Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Import order list',
                //     style: TextStyle(
                //         fontFamily: 'Poppins',
                //         fontSize: 30,
                //         color: Color(0xFF226B3F),
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width - 232,
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Party A (Seller)',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Color(0xFF226B3F),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            Input(
                                'Name of enterprise:',
                                enterpriseNameAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (enterpriseNameAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'The head office address:',
                                addressAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (addressAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'Number phone:',
                                phoneAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (phoneAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            Input(
                                'Bank account No:',
                                bankAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (bankAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                            Input(
                                'Opening at bank:',
                                bankOpenAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (bankOpenAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'Authorized peson:',
                                nameAuthorizedAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (nameAuthorizedAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            Input(
                                'Position:',
                                positionAuthorizedAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (positionAuthorizedAControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'The letter of authorization-NO:',
                                noLetterAuthorizationAControler,
                                Icons.abc,
                                "A",
                                isValidate
                                    ? (noLetterAuthorizationAControler.text ==
                                        '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                            Input(
                                'The letter of authorization-Date:',
                                dateLetterAuthorizationAControler,
                                Icons.calendar_month,
                                "A",
                                isValidate
                                    ? (dateLetterAuthorizationAControler.text ==
                                        '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            child: Divider(
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          'Party B (Buyer)',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Color(0xFF226B3F),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Input(
                                'Name of enterprise:',
                                enterpriseNameBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (enterpriseNameBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'The head office address:',
                                addressBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (addressBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'Number phone:',
                                phoneBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (phoneBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Input(
                                'Bank account No:',
                                bankBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (bankBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                            Input(
                                'Opening at bank:',
                                bankOpenBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (bankOpenBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'Authorized peson:',
                                nameAuthorizedBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (nameAuthorizedBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            Input(
                                'Position:',
                                positionAuthorizedBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (positionAuthorizedBControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'The letter of authorization-NO:',
                                noLetterAuthorizationBControler,
                                Icons.abc,
                                "B",
                                isValidate
                                    ? (noLetterAuthorizationBControler.text ==
                                        '')
                                    : false,
                                readOnly,
                                TextInputType.number),
                            Input(
                                'The letter of authorization-Date:',
                                dateLetterAuthorizationBControler,
                                Icons.calendar_month,
                                "B",
                                isValidate
                                    ? (dateLetterAuthorizationBControler.text ==
                                        '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  height: 64,
                  child: const Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  // height: 240 + 50 * 10,
                  height: MediaQuery.of(context).size.height - 70,
                  width: MediaQuery.of(context).size.width - 232,
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Input(
                              'Pursuant to:',
                              pursuantControler,
                              Icons.abc,
                              "none",
                              isValidate
                                  ? (pursuantControler.text == '')
                                  : false,
                              readOnly,
                              TextInputType.text,
                            ),
                            Input(
                                'Date created:',
                                dateCreatedControler,
                                Icons.abc,
                                "none",
                                isValidate
                                    ? (dateCreatedControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                            Input(
                                'At place:',
                                placeControler,
                                Icons.abc,
                                "none",
                                isValidate
                                    ? (placeControler.text == '')
                                    : false,
                                readOnly,
                                TextInputType.text),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'List Product',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  color: Color(0xFF226B3F),
                                  fontWeight: FontWeight.w700),
                            ),
                            if (!readOnly)
                              ElevatedButton(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: ModalAddProductImportOrder(
                                        products: products),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    ProductImportOrder productImportOrder =
                                        ProductImportOrder.fromJson(
                                            jsonDecode(value));
                                    setState(() {
                                      products.add(productImportOrder);
                                    });
                                  }
                                }),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'New ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                    maximumSize: MaterialStateProperty.all(
                                        const Size(110, 50)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15)),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFF226B3F))),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                            height: 410,
                            child: products.length > 0
                                ? TableProduct(
                                    // key: UniqueKey(),
                                    products: products,
                                    onPress: (name, product, index) {
                                      if (widget.importOrder.status ==
                                              'completed' ||
                                          widget.importOrder.status ==
                                              'canceled' ||
                                          widget.importOrder.status ==
                                              'checked') {
                                        Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 300, vertical: 16),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          flushbarStyle: FlushbarStyle.FLOATING,
                                          title: 'Notification',
                                          message: 'Order can\'t edit',
                                          duration: const Duration(seconds: 1),
                                        ).show(context);
                                        return;
                                      }
                                      if (product != null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content:
                                                ModalEditProductImportOrder(
                                              productImportOrder: product,
                                            ),
                                          ),
                                        ).then((value) {
                                          if (value != null) {
                                            ProductImportOrder newProduct =
                                                ProductImportOrder.fromJson(
                                                    jsonDecode(value));
                                            setState(() {
                                              products[index - 2] = newProduct;
                                            });
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          products.removeWhere((element) =>
                                              element.product!.name == name);
                                        });
                                      }
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Expanded(
                                          flex: 3,
                                          child: Image(
                                              height: 250,
                                              width: 250,
                                              image: AssetImage(
                                                  'assets/images/clipboard.png')),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Expanded(
                                            child: Text(
                                          'By clicking the "New" button above\nYou can add some product here',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ))
                                      ],
                                    ),
                                  )),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 80,
                          child: Row(
                            children: [
                              const Text(
                                'Note:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: noteController,
                                  readOnly: readOnly,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                'Total price: ' + calculateTotal(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isValidate = true;
                              });
                              // FocusScope.of(context).unfocus();
                              // print(products);

                              if (_formKey.currentState!.validate() &&
                                  !listController
                                      .any((element) => element.text == '') &&
                                  widget.importOrder.status != 'completed') {
                                CollectionReference importOrder =
                                    FirebaseFirestore.instance
                                        .collection('ImportOrder');
                                await importOrder
                                    .doc(widget.importOrder.idImportOrder)
                                    .update({
                                  'nameA': enterpriseNameAControler.text,
                                  'addressA': addressAControler.text,
                                  'phoneA': phoneAControler.text,
                                  'bankA': bankAControler.text,
                                  'atBankA': bankOpenAControler.text,
                                  'authorizedPersonA':
                                      nameAuthorizedAControler.text,
                                  'positionA':
                                      positionAuthorizedAControler.text,
                                  'noAuthorizationA':
                                      noLetterAuthorizationAControler.text,
                                  'dateAuthorizationA': dateA,
                                  // dateLetterAuthorizationAControler.text
                                  'nameB': enterpriseNameBControler.text,
                                  'addressB': addressBControler.text,
                                  'phoneB': phoneAControler.text,
                                  'bankB': bankBControler.text,
                                  'atBankB': bankOpenBControler.text,
                                  'authorizedPersonB':
                                      nameAuthorizedBControler.text,
                                  'positionB':
                                      positionAuthorizedBControler.text,
                                  'noAuthorizationB':
                                      noLetterAuthorizationBControler.text,
                                  'dateAuthorizationB': dateB,
                                  'pursuant': pursuantControler.text,
                                  'dateCreated': dateCreated,
                                  'atPlace': placeControler.text,
                                  'note': noteController.text,
                                  'totalPrice': calculateTotal(),
                                  'status': widget.importOrder.status,
                                  'listProduct':
                                      products.map((e) => e.toJson()).toList(),
                                  'listCheck': widget.importOrder.listCheck!
                                    ..add(false),
                                });
                                // await importOrder.add({
                                //   'nameA': enterpriseNameAControler.text,
                                //   'addressA': addressAControler.text,
                                //   'phoneA': phoneAControler.text,
                                //   'bankA': bankAControler.text,
                                //   'atBankA': bankOpenAControler.text,
                                //   'authorizedPersonA':
                                //       nameAuthorizedAControler.text,
                                //   'positionA': positionAuthorizedAControler.text,
                                //   'noAuthorizationA':
                                //       noLetterAuthorizationAControler.text,
                                //   'dateAuthorizationA': dateA,
                                //   // dateLetterAuthorizationAControler.text
                                //   'nameB': enterpriseNameBControler.text,
                                //   'addressB': addressBControler.text,
                                //   'phoneB': phoneAControler.text,
                                //   'bankB': bankBControler.text,
                                //   'atBankB': bankOpenBControler.text,
                                //   'authorizedPersonB':
                                //       nameAuthorizedBControler.text,
                                //   'positionB': positionAuthorizedBControler.text,
                                //   'noAuthorizationB':
                                //       noLetterAuthorizationBControler.text,
                                //   'dateAuthorizationB': dateB,
                                //   'pursuant': pursuantControler.text,
                                //   'dateCreated': dateCreated,
                                //   'atPlace': placeControler.text,
                                //   'note': noteController.text,
                                //   'totalPrice': calculateTotal(),
                                //   'status': 'pending',
                                //   'listProduct':
                                //       products.map((e) => e.toJson()).toList()
                                // }).then((value) => importOrder
                                //     .doc(value.id)
                                //     .update({'idImportOrder': value.id}));
                              }
                            },
                            child: const Text(
                              'Save ',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                maximumSize: MaterialStateProperty.all(
                                    const Size(110, 70)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 30)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF226B3F))),
                          ),
                        )
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Flexible Input(
      text,
      TextEditingController controller,
      IconData icon,
      String party,
      bool isValidate,
      bool readOnly,
      TextInputType textInputType) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  // return '';
                }
                return null;
              },
              keyboardType: textInputType,
              readOnly: readOnly ||
                  (text == 'Date created:' ||
                      text == 'The letter of authorization-Date:' ||
                      text == 'Pursuant to:'),
              controller: controller,
              // obscureText: true,
              decoration: InputDecoration(
                // label: Text(text),
                suffixIcon: icon != Icons.abc
                    ? IconButton(
                        icon: Icon(icon),
                        onPressed: () {
                          // _restorableDatePickerRouteFuture.present();
                          _selectDate(context, party);
                        },
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     borderSide: BorderSide(
                //         style: BorderStyle.solid,
                //         color: isValidate ? Colors.red : Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isValidate ? Colors.red : Colors.grey)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
