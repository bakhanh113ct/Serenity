import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class InputDropdown extends StatefulWidget {
  const InputDropdown(
      {super.key,
      required this.text,
      required this.listItem,
      required this.onSave,
      required this.initValue});
  final String text;
  final List<String> listItem;
  final Function onSave;
  final String initValue;
  @override
  State<InputDropdown> createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            // width: 300,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: DropdownButtonFormField2(
                value: widget.initValue != '' ? widget.initValue : null,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                // value: widget.text == 'Position' ? positionItems[1] : stateItems[1],
                // value: 'ngoc',
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: widget.listItem
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
                  if (value == null) {}
                },
                onChanged: (value) {
                  widget.onSave(value);
                },
                onSaved: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
