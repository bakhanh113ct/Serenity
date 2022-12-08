import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/table_product_checking.dart';

import '../widget/modal_edit_product_import_order.dart';

class CheckImportOrder extends StatefulWidget {
  const CheckImportOrder({super.key, required this.products});
  final List<ProductImportOrder> products;
  @override
  State<CheckImportOrder> createState() => _CheckImportOrderState();
}

class _CheckImportOrderState extends State<CheckImportOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Employee',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: Color(0xFF226B3F),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: TableProductChecking(
                  products: widget.products,
                  onPress: () {
                    print('object');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
