import 'package:flutter/material.dart';

import 'customerEdit_dialog.dart';

enum ActionOptions {
  edit,
  delete,
}

class CustomerActionsButton extends StatefulWidget {
  const CustomerActionsButton( {Key? key , required this.id}) : super(key: key);
  final String id;
  @override
  State<CustomerActionsButton> createState() => _CustomerActionsButtonState();
}

class _CustomerActionsButtonState extends State<CustomerActionsButton> {

  onEdit(){
    showDialog(
      context: context,
      builder: (context) {
        return CustomerEditDialog(
          id: widget.id,
          title: 'Edit Customer',
        );
      },
    );
  }
  onDelete(){}
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 140,
      child: PopupMenuButton<ActionOptions>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onSelected: (ActionOptions value) {
            if (value == ActionOptions.edit) {
              print(widget.id);
              onEdit();
            }else{
              onDelete();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor),
            width: 140,
            child: Center(
              child: Row(children: const <Widget>[
                Expanded(
                    child: Icon(
                  Icons.settings,
                  color: Colors.white,
                )),
                Expanded(
                    child: Center(
                        child: Text(
                  'Action',
                  style: TextStyle(color: Colors.white),
                ))),
                Expanded(
                    child: Icon(Icons.arrow_drop_down, color: Colors.white)),
              ]),
            ),
          ),
          itemBuilder: (_) => [
                const PopupMenuItem(
                  value: ActionOptions.edit,
                  child: ListTile(
                    trailing: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem(
                  value: ActionOptions.delete,
                  child: ListTile(
                    trailing: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                )
              ]),
    );
  }
}
