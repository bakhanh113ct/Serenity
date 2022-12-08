import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/input_dropdown.dart';
import 'package:serenity/widget/input_employee.dart';

import '../model/product.dart';

class ModalEditProductImportOrder extends StatefulWidget {
  const ModalEditProductImportOrder(
      {super.key, required this.productImportOrder});
  final ProductImportOrder productImportOrder;
  @override
  State<ModalEditProductImportOrder> createState() =>
      _ModalEditProductImportOrderState();
}

class _ModalEditProductImportOrderState
    extends State<ModalEditProductImportOrder> {
  final priceController = TextEditingController();
  final amountController = TextEditingController();
  final totalPriceController = TextEditingController();
  final inventoryController = TextEditingController();
  final noteController = TextEditingController();
  List<Product> listProduct = [];
  List<String> listDropdown = [];
  String price = '';
  final _formKey = GlobalKey<FormState>();
  String nameProduct = '';
  @override
  void initState() {
    nameProduct = widget.productImportOrder.product!.name!;
    priceController.text = widget.productImportOrder.product!.price!;
    amountController.text = widget.productImportOrder.amount!.toString();
    totalPriceController.text =
        (int.parse(widget.productImportOrder.product!.price!) *
                widget.productImportOrder.amount!)
            .toString();
    price = widget.productImportOrder.product!.price!;
    inventoryController.text = widget.productImportOrder.product!.category!;
    noteController.text = widget.productImportOrder.note!;

    final docProduct = FirebaseFirestore.instance.collection('Product');
    docProduct.get().then((value) {
      value.docs.forEach((element) {
        listProduct.add(Product.fromJson(element.data()));
        listDropdown.add(element.get('name'));
      });
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 500,
          width: 600,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Add Product',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: Color(0xFF226B3F),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          child: InputDropdown(
                            text: 'Name',
                            initValue: widget.productImportOrder.product!.name!,
                            listItem: listDropdown,
                            onSave: (nameProduct) {
                              changeData(nameProduct);
                            },
                          ),
                        ),
                        InputEmployee(
                            text: 'Inventory',
                            controller: inventoryController,
                            icon: Icons.abc_outlined,
                            onPress: () {}),
                        inputAmount(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      InputEmployee(
                          text: 'Price',
                          controller: priceController,
                          icon: Icons.abc_outlined,
                          onPress: () {}),
                      InputEmployee(
                          text: 'Note',
                          controller: noteController,
                          icon: Icons.abc,
                          onPress: () {}),
                      InputEmployee(
                          text: 'Total Price',
                          controller: totalPriceController,
                          icon: Icons.abc_outlined,
                          onPress: () {}),
                    ],
                  ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  style: ButtonStyle(
                      maximumSize: MaterialStateProperty.all(Size(110, 50)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF226B3F))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Cancel ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(noteController.text);
                      ProductImportOrder productImportOrder =
                          ProductImportOrder(
                              product: listProduct
                                  .where(
                                      (element) => element.name == nameProduct)
                                  .first,
                              amount: int.parse(amountController.text),
                              note: noteController.text);
                      // print(productImportOrder.toJson().toString());
                      Navigator.pop(context, jsonEncode(productImportOrder));
                    }
                  },
                  style: ButtonStyle(
                      maximumSize: MaterialStateProperty.all(Size(110, 50)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF226B3F))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Save ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Flexible inputAmount() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final format = NumberFormat("###,###.###", "tr_TR");
                if (value == '')
                  totalPriceController.text = priceController.text;
                else {
                  totalPriceController.text = format
                      .format((int.parse(price) * int.parse(value)))
                      .toString();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter number';
              },
              controller: amountController,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void changeData(nameProduct) {
    final format = NumberFormat("###,###.###", "tr_TR");
    Product product =
        listProduct.where((element) => element.name == nameProduct).first;
    price = product.price!;
    this.nameProduct = product.name!;
    priceController.text = format.format(int.parse(product.price!)).toString();
    inventoryController.text = product.category!;
  }
}
