import 'package:flutter/material.dart';

import 'report_trouble_edit_dialog.dart';
import 'trouble_edit_dialog.dart';


enum ActionOptions { view, edit, close, report }

class TroubleMoreButton extends StatefulWidget {
  const TroubleMoreButton({Key? key, required this.idTrouble})
      : super(key: key);
  final String idTrouble;
  @override
  State<TroubleMoreButton> createState() => _TroubleMoreButtonState();
}

class _TroubleMoreButtonState extends State<TroubleMoreButton> {
  onView() {
    showDialog(
      context: context,
      builder: (context) {
        return TroubleEditDialog(
          idTrouble: widget.idTrouble,
          title: 'View Trouble',
          isEdit: false,
        );
      },
    );
  }

  onEdit() {
    showDialog(
      context: context,
      builder: (context) {
        return TroubleEditDialog(
            idTrouble: widget.idTrouble,
            title: 'Edit Trouble',
            isEdit: true);
      },
    );
  }
  onReport() {
    showDialog(
      context: context,
      builder: (context) {
        return ReportTroubleEditDialog(
            idTrouble: widget.idTrouble, title: 'Create Trouble Report', isEdit: true);
      },
    );
  }

  onClose() {
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
            if (value == ActionOptions.report) {
              onReport();
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
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    title: Text('Edit'),
                  ),
                ),
                 const PopupMenuItem(
                  value: ActionOptions.report,
                  child: ListTile(
                    trailing: Icon(
                      Icons.report,
                      color: Colors.black,
                    ),
                    title: Text('Make a report'),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: ActionOptions.close,
                  child: ListTile(
                    trailing: Icon(Icons.close_rounded, color: Colors.black),
                    title: Text('Close'),
                  ),
                ),
              ]),
    );
  }
}
