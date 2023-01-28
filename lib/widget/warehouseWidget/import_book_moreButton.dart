import 'package:flutter/material.dart';
import 'package:serenity/model/product.dart';
import 'package:serenity/widget/warehouseWidget/check_warehouse_dialog.dart';


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

  onView() {
    showDialog(
      context: context,
      builder: (context) {
        // return ImportBookEditDialog(
        //   idImportBook: widget.ImportBook.idImportBook!,
        //   title: 'View ImportBook',
        //   isEdit: false,
        // );
        return const CheckWarehouseDialog();
      },
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
            alignment: Alignment.center,
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
                          trailing:
                              Icon(Icons.view_comfortable, color: Colors.black),
                          title: Text('View'),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: ActionOptions.close,
                        child: ListTile(
                          trailing:
                              Icon(Icons.close_rounded, color: Colors.black),
                          title: Text('Close'),
                        ),
                      ),
                    ]),
          );
  }
}
