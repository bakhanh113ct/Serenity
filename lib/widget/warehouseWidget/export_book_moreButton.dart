import 'package:flutter/material.dart';
import 'package:serenity/model/export_product.dart';


enum ActionOptions { view, close }

class ExportBookMoreButton extends StatefulWidget {
  const ExportBookMoreButton({Key? key, required this.exportBook})
      : super(key: key);
  final ExportProduct exportBook;
  @override
  State<ExportBookMoreButton> createState() =>
      _ExportBookMoreButtonState();
}

class _ExportBookMoreButtonState extends State<ExportBookMoreButton> {
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
        return Container();
      },
    );
  }

  onPrint() {}

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
