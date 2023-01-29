import 'package:flutter/material.dart';
import 'package:serenity/widget/warehouseWidget/receipt_document_dialog.dart';
import 'package:serenity/widget/warehouseWidget/warehouse_action.dart';


class WarehouseHeader extends StatelessWidget {
  const WarehouseHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.left,
                ),
              ),
        
              const WarehouseAction(),
      ],
    );
  }
}
