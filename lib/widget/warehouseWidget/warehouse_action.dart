import 'package:flutter/material.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/widget/warehouseWidget/check_warehouse_dialog.dart';

import 'receipt_document_dialog.dart';

enum ActionOptions { makeRc, check}

class WarehouseAction extends StatefulWidget {
  const WarehouseAction({Key? key}) : super(key: key);
  @override
  State<WarehouseAction> createState() => _WarehouseActionState();
}

class _WarehouseActionState extends State<WarehouseAction> {
  onMakeRc() {
    showDialog(
      context: context,
      builder: (context) {
        return const ReceiptDocumentEditDialog(
          idReceiptDocument: '',
          title: 'Make Receipt Document',
          isEdit: true,
        );
      },
    );
  }

  onCheckWarehouse() {
     showDialog(
      context: context,
      builder: (context) {
        return const CheckWarehouseDialog(
          
        );
      },
    );
  }

  onClose() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PopupMenuButton<ActionOptions>(
          onSelected: (ActionOptions value) {
            if (value == ActionOptions.makeRc) {
              onMakeRc();
              return;
            }
            if (value == ActionOptions.check) {
              onCheckWarehouse();
              return;
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: CustomColor.second,
              borderRadius: BorderRadius.circular(10)
            ),
            height: 50,
            width: 120,
          
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Action',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
          ),
          itemBuilder: (_) => [
                const PopupMenuItem(
                  value: ActionOptions.makeRc,
                  child: ListTile(
                    trailing: Icon(Icons.receipt, color: Colors.black),
                    title: Text('Make Receipt Document'),
                  ),
                ),
                const PopupMenuItem(
                  value: ActionOptions.check,
                  child: ListTile(
                    trailing: Icon(
                      Icons.checklist_rounded,
                      color: Colors.black,
                    ),
                    title: Text('Check Warehouse'),
                  ),
                ),

                
              ]),
    );
  }
}
