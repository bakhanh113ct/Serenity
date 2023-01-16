import 'package:flutter/material.dart';
import 'package:serenity/widget/warehouseWidget/receipt_document_dialog.dart';


class WarehouseHeader extends StatelessWidget {
  const WarehouseHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 50),
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const ReceiptDocumentEditDialog(
                        idReceiptDocument: '',
                        isEdit: true,
                        title: 'Make a product receipt document',
                      );
                    },
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Create',
                        style: TextStyle(fontSize: 15),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
