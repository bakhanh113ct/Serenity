import 'package:flutter/material.dart';
import 'package:serenity/model/product.dart';

import '../../repository/product_repository.dart';
import '../modal_detail_product.dart';


enum ActionOptions { view,  close }

class ImportBookMoreButton extends StatefulWidget {
  const ImportBookMoreButton({Key? key, required this.importBook})
      : super(key: key);
  final Product importBook;
  @override
  State<ImportBookMoreButton> createState() =>
      _ImportBookMoreButtonState();
}

class _ImportBookMoreButtonState extends State<ImportBookMoreButton> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  onView() async {
    var product =
        await ProductRepository().getProductByName(widget.importBook.name!);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ModalDetailProductPage(product: product),
      ),
    );
  }

  onClose() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Container(
            alignment: Alignment.centerLeft,
            child: PopupMenuButton<ActionOptions>(
                onSelected: (ActionOptions value) {
                  if (value == ActionOptions.view) {
                    onView();
                    return;
                  }
                
                  if (value == ActionOptions.close) {
                    onClose();
                    return;
                  }
                },
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: ActionOptions.view,
                        child: ListTile(
                          leading:
                              Icon(Icons.view_comfortable, color: Colors.black),
                          title: Text('View'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: ActionOptions.close,
                        child: ListTile(
                          leading:
                              Icon(Icons.close_rounded, color: Colors.black),
                          title: Text('Close'),
                        ),
                      ),
                    ]),
          );
  }
}
