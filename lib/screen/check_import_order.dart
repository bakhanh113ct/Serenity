import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/widget/table_product_checking.dart';

import '../widget/modal_choose_trouble.dart';
import '../widget/modal_edit_product_import_order.dart';

class CheckImportOrder extends StatefulWidget {
  const CheckImportOrder({super.key, required this.importOrder});
  final ImportOrder importOrder;
  @override
  State<CheckImportOrder> createState() => _CheckImportOrderState();
}

class _CheckImportOrderState extends State<CheckImportOrder> {
  List<String> listTrouble = [];
  @override
  void initState() {
    listTrouble = widget.importOrder.listProduct!
        .map((e) => e.trouble.toString())
        .toList();
    super.initState();
  }

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
              'Check Order',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: Color(0xFF226B3F),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TableProductChecking(
                  importOrder: widget.importOrder,
                  onOpenReport: (index) async {
                    var result = await showDialog<String>(
                      // barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: ModalChooseTrouble(
                          importOrder: widget.importOrder,
                        ),
                      ),
                    );
                    if (result != null) {
                      listTrouble[index] = result;
                    }
                    ;
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
