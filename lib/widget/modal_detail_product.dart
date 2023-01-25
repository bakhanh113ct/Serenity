import 'package:flutter/material.dart';
import 'package:serenity/model/product.dart';

import 'input_dropdown.dart';
import 'input_employee.dart';

class ModalDetailProductPage extends StatefulWidget {
  const ModalDetailProductPage({super.key,required this.product});
  final Product product;
  @override
  State<ModalDetailProductPage> createState() => _ModalDetailProductPageState();
}

class _ModalDetailProductPageState extends State<ModalDetailProductPage> {
  final priceController = TextEditingController();
  final historicalCostController = TextEditingController();
  final decriptionController = TextEditingController();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  String price = '';
  final _formKey = GlobalKey<FormState>();
  String nameProduct = '';
  @override
  void initState() {
    nameController.text=widget.product.name!;
    priceController.text=widget.product.price!;
    historicalCostController.text=widget.product.historicalCost!;
    decriptionController.text=widget.product.content!;
    categoryController.text=widget.product.category!;
    super.initState();
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
              'Detail Product',
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
                    child: Image.network(widget.product.image!)
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Row(children: [
                        InputEmployee(
                          text: 'Name',
                          controller: nameController,
                          icon: Icons.abc_outlined,
                          onPress: () {}),
                          InputEmployee(
                          text: 'Category',
                          controller: categoryController,
                          icon: Icons.abc_outlined,
                          onPress: () {}),
                      ],),
                      Row(children: [
                        InputEmployee(
                          text: 'Price',
                          controller: priceController,
                          icon: Icons.abc_outlined,
                          onPress: () {}),
                          InputEmployee(
                          text: 'Historical Cost',
                          controller: historicalCostController,
                          icon: Icons.abc_outlined,
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
              readOnly: true,
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
                // ElevatedButton(
                //   onPressed: () async{
                //     if (_formKey.currentState!.validate()) {
                      
                //     }
                //   },
                //   style: ButtonStyle(
                //       maximumSize: MaterialStateProperty.all(Size(110, 50)),
                //       padding: MaterialStateProperty.all(
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                //       backgroundColor:
                //           MaterialStateProperty.all(Color(0xFF226B3F))),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Text(
                //         'Add',
                //         style: TextStyle(fontSize: 20),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}