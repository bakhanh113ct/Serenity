import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/widget/input_employee.dart';

class ModalChooseTrouble extends StatefulWidget {
  const ModalChooseTrouble({super.key, required this.importOrder});
  final ImportOrder importOrder;
  @override
  State<ModalChooseTrouble> createState() => _ModalChooseTroubleState();
}

class _ModalChooseTroubleState extends State<ModalChooseTrouble> {
  String troubleValue = 'aaa';
  final List<String> troubles = ['aaa', 'bbb'];
  TextEditingController otherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      color: Colors.white,
      child: Column(children: [
        const Text(
          'Trouble',
          style: TextStyle(
              // fontFamily: 'Poppins',
              fontSize: 30,
              color: Color(0xFF226B3F),
              fontWeight: FontWeight.w600),
        ),
        comboBox('Trouble'),
        InputEmployee(
            text: 'Other',
            controller: otherController,
            icon: Icons.edit,
            onPress: () {}),
        ElevatedButton(
          onPressed: () async {
            ImportOrder newImportOrder = widget.importOrder;
            widget.importOrder.listProduct![0].trouble = troubleValue;
            Navigator.pop(context, troubleValue);
            // await FirebaseFirestore.instance
            //     .collection('ImportOrder')
            //     .doc(widget.importOrder.idImportOrder)
            //     .update({
            //   'listProduct':
            //       newImportOrder.listProduct!.map((e) => e.toJson()).toList(),
            // });
          },
          style: ButtonStyle(
              // maximumSize:
              //     MaterialStateProperty.all(Size(110, 60)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 15)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF226B3F))),
          child: const Text(
            'Save ',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]),
    );
  }

  Padding comboBox(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 75,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Choose one',
                  style: TextStyle(fontSize: 18),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                value: troubleValue,
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: troubles
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    // return 'Please select gender.';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  troubleValue = value!;
                },
                onSaved: (value) {
                  troubleValue = value!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
