

import 'package:flutter/material.dart';

import 'trouble_edit_dialog.dart';

class TroubleHeader extends StatelessWidget {
  const TroubleHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          height: 50,
          width: 120,
          child: ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return const TroubleEditDialog(
                  idTrouble: '',
                  title: 'Add Trouble',
                  isEdit: true,
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
    );
  }
}
