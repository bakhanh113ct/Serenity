import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/party_import_order.dart';
import 'package:serenity/widget/table_product.dart';
import '../widget/table_content.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context, String party) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
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
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height + 5,
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
                      SizedBox(
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
                          ),
                          Input(
                            'The head office address:',
                            addressAControler,
                            Icons.abc,
                            "A",
                            isValidate ? (addressAControler.text == '') : false,
                          ),
                          Input(
                            'Number phone:',
                            phoneAControler,
                            Icons.abc,
                            "A",
                            isValidate ? (phoneAControler.text == '') : false,
                          ),
                        ],
                      ),
                      SizedBox(
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
                          ),
                          Input(
                            'Opening at bank:',
                            bankOpenAControler,
                            Icons.abc,
                            "A",
                            isValidate
                                ? (bankOpenAControler.text == '')
                                : false,
                          ),
                          Input(
                            'Authorized peson:',
                            nameAuthorizedAControler,
                            Icons.abc,
                            "A",
                            isValidate
                                ? (nameAuthorizedAControler.text == '')
                                : false,
                          ),
                        ],
                      ),
                      SizedBox(
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
                          ),
                          Input(
                            'The letter of authorization-NO:',
                            noLetterAuthorizationAControler,
                            Icons.abc,
                            "A",
                            isValidate
                                ? (noLetterAuthorizationAControler.text == '')
                                : false,
                          ),
                          Input(
                            'The letter of authorization-Date:',
                            dateLetterAuthorizationAControler,
                            Icons.calendar_month,
                            "A",
                            isValidate
                                ? (dateLetterAuthorizationAControler.text == '')
                                : false,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          child: Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
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
                          ),
                          Input(
                            'The head office address:',
                            addressBControler,
                            Icons.abc,
                            "B",
                            isValidate ? (addressBControler.text == '') : false,
                          ),
                          Input(
                            'Number phone:',
                            phoneBControler,
                            Icons.abc,
                            "B",
                            isValidate ? (phoneBControler.text == '') : false,
                          ),
                        ],
                      ),
                      SizedBox(
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
                          ),
                          Input(
                            'Opening at bank:',
                            bankOpenBControler,
                            Icons.abc,
                            "B",
                            isValidate
                                ? (bankOpenBControler.text == '')
                                : false,
                          ),
                          Input(
                            'Authorized peson:',
                            nameAuthorizedBControler,
                            Icons.abc,
                            "B",
                            isValidate
                                ? (nameAuthorizedBControler.text == '')
                                : false,
                          ),
                        ],
                      ),
                      SizedBox(
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
                          ),
                          Input(
                            'The letter of authorization-NO:',
                            noLetterAuthorizationBControler,
                            Icons.abc,
                            "B",
                            isValidate
                                ? (noLetterAuthorizationBControler.text == '')
                                : false,
                          ),
                          Input(
                            'The letter of authorization-Date:',
                            dateLetterAuthorizationBControler,
                            Icons.calendar_month,
                            "B",
                            isValidate
                                ? (dateLetterAuthorizationBControler.text == '')
                                : false,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),

                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => ProductInvoice(),
                      //           ));
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           'Next ',
                      //           style: TextStyle(fontSize: 20),
                      //         ),
                      //         Icon(
                      //           Icons.arrow_right,
                      //           size: 30,
                      //         )
                      //       ],
                      //     ),
                      //     style: ButtonStyle(
                      //         maximumSize:
                      //             MaterialStateProperty.all(Size(110, 60)),
                      //         padding: MaterialStateProperty.all(
                      //             EdgeInsets.symmetric(
                      //                 vertical: 16, horizontal: 15)),
                      //         backgroundColor: MaterialStateProperty.all(
                      //             Color(0xFF226B3F))),
                      //   ),
                      // )
                    ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                height: 64,
                child: Divider(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                // height: 240 + 50 * 10,
                height: 760,
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
                            isValidate ? (pursuantControler.text == '') : false,
                            // true,
                          ),
                          Input(
                            'Date created:',
                            dateCreatedControler,
                            Icons.abc,
                            "none",
                            isValidate
                                ? (dateCreatedControler.text == '')
                                : false,
                          ),
                          Input(
                            'At place:',
                            placeControler,
                            Icons.abc,
                            "none",
                            isValidate ? (placeControler.text == '') : false,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Party B (Buyer)',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Color(0xFF226B3F),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(height: 410, child: TableProduct()),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Text(
                              'Note:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: TextField(
                                controller: noteController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text(
                              'Total price: \$200.00',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isValidate = true;
                            });
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate() &&
                                !listController
                                    .any((element) => element.text == '')) {
                              // PartyImportOrder partyA = PartyImportOrder(
                              //     name: enterpriseNameAControler.text,
                              //     address: addressAControler.text,
                              //     phone: phoneAControler.text,
                              //     bank: bankAControler.text,
                              //     atBank: bankOpenAControler.text,
                              //     authorizedPerson:
                              //         nameAuthorizedAControler.text,
                              //     position: positionAuthorizedAControler.text,
                              //     noAuthorization: int.parse(
                              //         noLetterAuthorizationAControler.text),
                              //     dateAuthorization: DateTime.tryParse(
                              //         dateLetterAuthorizationAControler
                              //             .text)
                              //             );
                              // print(partyA.noAuthorization);
                              CollectionReference importOrder =
                                  FirebaseFirestore.instance
                                      .collection('ImportOrder');
                              await importOrder.add({
                                'nameA': enterpriseNameAControler.text,
                                'addressA': addressAControler.text,
                                'phoneA': phoneAControler.text,
                                'bankA': bankAControler.text,
                                'atBankA': bankOpenAControler.text,
                                'authorizedPersonA':
                                    nameAuthorizedAControler.text,
                                'positionA': positionAuthorizedAControler.text,
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
                                'positionB': positionAuthorizedBControler.text,
                                'noAuthorizationB':
                                    noLetterAuthorizationBControler.text,
                                'dateAuthorizationB': dateB,
                                'pursuant': pursuantControler.text,
                                'dateCreated': dateCreated,
                                'atPlace': placeControler.text,
                                'note': noteController.text,
                                'totalPrice': 200,
                                'status': 'pending',
                                'listProduct': [
                                  {'id': "idnef", 'price': 1000}
                                ]
                              }).then((value) => importOrder
                                  .doc(value.id)
                                  .update({'idImportOrder': value.id}));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                'Next ',
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: 30,
                              )
                            ],
                          ),
                          style: ButtonStyle(
                              maximumSize:
                                  MaterialStateProperty.all(Size(110, 60)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 15)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF226B3F))),
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
      String party, bool isValidate) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  // return '';

                }
                return null;
              },
              readOnly: text == 'Date created:' ||
                  text == 'The letter of authorization-Date:',
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
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     borderSide: BorderSide(
                //         style: BorderStyle.solid,
                //         color: isValidate ? Colors.red : Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isValidate ? Colors.red : Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // // TODO: implement restorationId
  // String? get restorationId => 'aa';
}


