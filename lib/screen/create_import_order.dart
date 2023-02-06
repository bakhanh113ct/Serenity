import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/screen/testdropdown.dart';
import 'package:serenity/widget/modal_add_product_import_order.dart';
import 'package:serenity/widget/modal_edit_product_import_order.dart';
import 'package:serenity/widget/table_product.dart';
import '../widget/table_import_order.dart';

class CreateImportOrder extends StatefulWidget {
  const CreateImportOrder({super.key});

  @override
  State<CreateImportOrder> createState() => _CreateImportOrderState();
}

class _CreateImportOrderState extends State<CreateImportOrder> {
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context, String party) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
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
  }

  late DateTime? dateA, dateB, dateCreated;
  late TextEditingController enterpriseNameAControler;
  late TextEditingController addressAControler;
  late TextEditingController phoneAControler;
  late TextEditingController bankAControler;
  late TextEditingController bankOpenAControler;
  late TextEditingController nameAuthorizedAControler;
  late TextEditingController positionAuthorizedAControler;
  late TextEditingController noLetterAuthorizationAControler;
  late TextEditingController dateLetterAuthorizationAControler;

  late TextEditingController enterpriseNameBControler;
  late TextEditingController addressBControler;
  late TextEditingController phoneBControler;
  late TextEditingController bankBControler;
  late TextEditingController bankOpenBControler;
  late TextEditingController nameAuthorizedBControler;
  late TextEditingController positionAuthorizedBControler;
  late TextEditingController noLetterAuthorizationBControler;
  late TextEditingController dateLetterAuthorizationBControler;

  late TextEditingController pursuantControler;
  late TextEditingController dateCreatedControler;
  late TextEditingController placeControler;
  late TextEditingController noteController;

  late List<TextEditingController> listController;
  List<ProductImportOrder> products = <ProductImportOrder>[];

  @override
  void initState() {
    enterpriseNameAControler = TextEditingController();
    addressAControler = TextEditingController();
    phoneAControler = TextEditingController();
    bankAControler = TextEditingController();
    bankOpenAControler = TextEditingController();
    nameAuthorizedAControler = TextEditingController();
    positionAuthorizedAControler = TextEditingController();
    noLetterAuthorizationAControler = TextEditingController();
    dateLetterAuthorizationAControler = TextEditingController();

    enterpriseNameBControler = TextEditingController();
    addressBControler = TextEditingController();
    phoneBControler = TextEditingController();
    bankBControler = TextEditingController();
    bankOpenBControler = TextEditingController();
    nameAuthorizedBControler = TextEditingController();
    positionAuthorizedBControler = TextEditingController();
    noLetterAuthorizationBControler = TextEditingController();
    dateLetterAuthorizationBControler = TextEditingController();

    pursuantControler = TextEditingController();
    dateCreatedControler = TextEditingController();
    placeControler = TextEditingController();
    noteController = TextEditingController();

    pursuantControler.text =
        'Pursuant to the civil code No. 91/2015/QH13 dated November 24, 2015';
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
    dateCreatedControler.text =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    dateCreated = DateTime.now();
    super.initState();
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
    return Scaffold(
      backgroundColor: const Color(0xFFEBFDF2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Import order list',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Color(0xFF226B3F),
                      fontWeight: FontWeight.w600),
                ),
              ),
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
                              TextInputType.text),
                          Input(
                              'The head office address:',
                              addressAControler,
                              Icons.abc,
                              "A",
                              isValidate
                                  ? (addressAControler.text == '')
                                  : false,
                              TextInputType.text),
                          Input(
                              'Number phone:',
                              phoneAControler,
                              Icons.abc,
                              "A",
                              isValidate ? (phoneAControler.text == '') : false,
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
                              isValidate ? (bankAControler.text == '') : false,
                              TextInputType.number),
                          Input(
                              'Opening at bank:',
                              bankOpenAControler,
                              Icons.abc,
                              "A",
                              isValidate
                                  ? (bankOpenAControler.text == '')
                                  : false,
                              TextInputType.text),
                          Input(
                              'Authorized peson:',
                              nameAuthorizedAControler,
                              Icons.abc,
                              "A",
                              isValidate
                                  ? (nameAuthorizedAControler.text == '')
                                  : false,
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
                              TextInputType.text),
                          Input(
                              'The letter of authorization-NO:',
                              noLetterAuthorizationAControler,
                              Icons.abc,
                              "A",
                              isValidate
                                  ? (noLetterAuthorizationAControler.text == '')
                                  : false,
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
                              TextInputType.text),
                          Input(
                              'The head office address:',
                              addressBControler,
                              Icons.abc,
                              "B",
                              isValidate
                                  ? (addressBControler.text == '')
                                  : false,
                              TextInputType.text),
                          Input(
                              'Number phone:',
                              phoneBControler,
                              Icons.abc,
                              "B",
                              isValidate ? (phoneBControler.text == '') : false,
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
                              isValidate ? (bankBControler.text == '') : false,
                              TextInputType.number),
                          Input(
                              'Opening at bank:',
                              bankOpenBControler,
                              Icons.abc,
                              "B",
                              isValidate
                                  ? (bankOpenBControler.text == '')
                                  : false,
                              TextInputType.text),
                          Input(
                              'Authorized peson:',
                              nameAuthorizedBControler,
                              Icons.abc,
                              "B",
                              isValidate
                                  ? (nameAuthorizedBControler.text == '')
                                  : false,
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
                              TextInputType.text),
                          Input(
                              'The letter of authorization-NO:',
                              noLetterAuthorizationBControler,
                              Icons.abc,
                              "B",
                              isValidate
                                  ? (noLetterAuthorizationBControler.text == '')
                                  : false,
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
                height: MediaQuery.of(context).size.height - 50,
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
                              // true,
                              TextInputType.text),
                          Input(
                              'Date created:',
                              dateCreatedControler,
                              Icons.abc,
                              "none",
                              isValidate
                                  ? (dateCreatedControler.text == '')
                                  : false,
                              TextInputType.text),
                          Input(
                              'At place:',
                              placeControler,
                              Icons.abc,
                              "none",
                              isValidate ? (placeControler.text == '') : false,
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
                                fontWeight: FontWeight.w500),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const TestDropDown(),
                              //     ));
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
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
                              });
                            },
                            style: ButtonStyle(
                                maximumSize: MaterialStateProperty.all(
                                    const Size(110, 50)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF226B3F))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'New ',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
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
                                  key: UniqueKey(),
                                  products: products,
                                  onPress: (name, product, index) {
                                    if (product != null) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          content: ModalEditProductImportOrder(
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
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
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
                            FocusManager.instance.primaryFocus?.unfocus();

                            // print(products);

                            if (_formKey.currentState!.validate() &&
                                !listController
                                    .any((element) => element.text == '')) {
                              // print('â');
                              CollectionReference importOrder =
                                  FirebaseFirestore.instance
                                      .collection('ImportOrder');
                              await importOrder
                                  .add({
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
                                    'status': 'pending',
                                    'listProduct': products
                                        .map((e) => e.toJson())
                                        .toList(),
                                    'listCheck': List.generate(
                                        products.length, (index) => false),
                                  })
                                  .then((value) => importOrder
                                      .doc(value.id)
                                      .update({'idImportOrder': value.id}))
                                  .then((value) => Flushbar(
                                        flushbarPosition: FlushbarPosition.TOP,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 300, vertical: 16),
                                        borderRadius: BorderRadius.circular(8),
                                        flushbarStyle: FlushbarStyle.FLOATING,
                                        title: 'Notification',
                                        message:
                                            'Create import order successful',
                                        duration: const Duration(seconds: 3),
                                      ).show(context));
                            }
                          },
                          style: ButtonStyle(
                              maximumSize: MaterialStateProperty.all(
                                  const Size(110, 60)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 15)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF226B3F))),
                          child: const Text(
                            'Save ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Flexible Input(text, TextEditingController controller, IconData icon,
      String party, bool isValidate, TextInputType textInputType) {
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
              readOnly: text == 'Date created:' ||
                  text == 'The letter of authorization-Date:' ||
                  text == 'Pursuant to:',
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
