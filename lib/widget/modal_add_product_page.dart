import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocProduct/bloc/product_bloc.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/input_dropdown.dart';
import 'package:serenity/widget/input_employee.dart';

import '../model/product.dart';

class ModalAddProductPage extends StatefulWidget {
  const ModalAddProductPage({super.key, required this.category});
  final List<String> category;
  @override
  State<ModalAddProductPage> createState() =>
      _ModalAddProductPageState();
}

class _ModalAddProductPageState extends State<ModalAddProductPage> {
  final storage = FirebaseStorage.instance.ref();
  final products=FirebaseFirestore.instance.collection("Product");
  final priceController = TextEditingController();
  final historicalCostController = TextEditingController();
  final decriptionController = TextEditingController();
  final nameController = TextEditingController();
  String category="";
  File? _file;
  String price = '';
  final _formKey = GlobalKey<FormState>();
  String nameProduct = '';
  Future _getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTempory = File(image.path);
    setState(() {
      _file = imageTempory;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future _getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTempory = File(image.path);
    setState(() {
      _file = imageTempory;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 550,
          width: 800,
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
                    flex: 1,
                    child: InkWell(
                      onTap: _editImage,
                      child: Image(
                        image: _file == null
                            ? const AssetImage("assets/images/noImage.jpg")
                            : Image.file(
                                _file!,
                                fit: BoxFit.cover,
                              ).image,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Row(children: [
                        InputEmployee(
                          text: 'Name',
                          controller: nameController,
                          icon: Icons.abc,
                          onPress: () {}),
                          Flexible(
                            child: InputDropdown(
                              text: 'Category',
                              initValue: '',
                              listItem: widget.category,
                              onSave: (nameProduct) {
                                category=nameProduct;
                              },
                            ),
                          ),
                      ],),
                      Row(children: [
                        InputEmployee(
                          text: 'Price',
                          controller: priceController,
                          icon: Icons.abc,
                          onPress: () {}),
                          InputEmployee(
                          text: 'Historical Cost',
                          controller: historicalCostController,
                          icon: Icons.abc,
                          onPress: () {}),
                      ],),
                      Container(
                        height: 200,
                        child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Decription",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              maxLines: 5,
              keyboardType:
                  TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter ' ;
              },
              controller: decriptionController,
              decoration: InputDecoration(
        
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
                      ),
                  ]),)
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
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      String id='';
                      await products.add({
                        "name":nameController.text.trim(),
                        "category":category,
                        "price":priceController.text.trim(),
                        "historicalCost":historicalCostController.text.trim(),
                        "content":decriptionController.text.trim(),
                        "amount":"0",
                      }).then((value) {
                        id=value.id;
                      });
                        final task = await storage.child("$id.jpg").putFile(_file!);
                        final linkImage = await task.ref.getDownloadURL();
                        products.doc(id).update({"idProduct":id,"image":linkImage});
                        BlocProvider.of<ProductBloc>(context).add(LoadProduct());
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
                        'Add',
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
  void _editImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Text(
                  "Upload Photo",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Text("Choose Product Picture"),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text("Take Photo"),
                  onPressed: _getImageCamera,
                ),
                ElevatedButton(
                  child: Text("Choose From Library"),
                  onPressed: _getImageGallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
