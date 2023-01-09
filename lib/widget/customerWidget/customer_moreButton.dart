import 'package:flutter/material.dart';

import 'customer_edit_dialog.dart';

enum ActionOptions {
  view,
  edit,
  close
}

class CustomerMoreButton extends StatefulWidget {
  const CustomerMoreButton( {Key? key , required this.idCustomer}) : super(key: key);
  final String idCustomer;
  @override
  State<CustomerMoreButton> createState() => _CustomerMoreButtonState();
}

class _CustomerMoreButtonState extends State<CustomerMoreButton> {
   onView() {
    print(widget.idCustomer);
    showDialog(
      context: context,
      builder: (context) {
        return CustomerEditDialog(
          idCustomer: widget.idCustomer,
          title: 'View Customer',
          isEdit: false,
        );
      },
    );
  }
  onEdit(){
    showDialog(
      context: context,
      builder: (context) {
        return CustomerEditDialog(
          idCustomer: widget.idCustomer,
          title: 'Edit Customer',
          isEdit: true
        );
      },
    );
  }
  onClose(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PopupMenuButton<ActionOptions>(
          onSelected: (ActionOptions value) {
            if (value == ActionOptions.view) {
              onView();
              return;
      
            }
            if (value == ActionOptions.edit) {
              onEdit();
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
                    trailing: Icon(Icons.view_comfortable, color: Colors.black),
                    title: Text('View'),
                  ),
                ),
                const PopupMenuItem(
                  value: ActionOptions.edit,
                  child: ListTile(
                    trailing: Icon(Icons.edit, color: Colors.black,),
                    title: Text('Edit'),
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
