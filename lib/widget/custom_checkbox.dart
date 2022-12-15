import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, required this.onPress, required this.index});
  final Function onPress;
  final int index;
  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
          fillColor: MaterialStateProperty.all(const Color(0xFF226B3F)),
          value: isChecked,
          onChanged: (value) {
            widget.onPress(widget.index, value);
            setState(() {
              isChecked = !isChecked;
            });
          }),
    );
  }
}
