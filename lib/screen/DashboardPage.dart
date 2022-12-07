import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../routes/Routes.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFEBFDF2),
        child: Column(
          children: [
            ElevatedButton(onPressed: ()async{
              final products=FirebaseFirestore.instance.collection("Product");
              final String response = await rootBundle.loadString('assets/data.json');
              final data = await json.decode(response);
              data['product'].forEach((e){
                products.add({
                  "name":e['name'],
                  "price":e['price'].toString(),
                  "content":e['content'],
                  "image":e['image'],
                  "category":e['category'],
                  "amount":e['amount'].toString(),
                  "historicalCost":e['historicalCost'].toString(),
                }).then((value) {
                  products.doc(value.id).update({"idProduct":value.id});
                });
              });
            }, child: Text("Push data")),
            // ElevatedButton(onPressed: createPdf, child: Text("Test"))
            
          ],
        ),
      ),
    );
  }
}