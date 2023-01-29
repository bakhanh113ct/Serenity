import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key,
      required this.onPress,
      required this.index,
      required this.isChecked,
      required this.listTrouble});
  final Function onPress;
  final int index;
  final bool isChecked;
  final List<String> listTrouble;
  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
          fillColor: MaterialStateProperty.all(const Color(0xFF226B3F)),
          value: isChecked,
          onChanged: (value) {
            widget.onPress(widget.index, value);
            if (widget.listTrouble[widget.index] != '' && isChecked == false) {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                      title: Text('Confirm'),
                      titleTextStyle:
                          TextStyle(fontSize: 26, color: Colors.black),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Yes'),
                          onPressed: () {
                            widget.listTrouble[widget.index] = '';
                            setState(() {
                              isChecked = !isChecked;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      content: Container(
                        height: 60,
                        width: 300,
                        color: Colors.white,
                        child: Column(children: const [
                          Expanded(
                            child: Text(
                              'This product is having problems, would you like to confirm?',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]),
                      )));
            } else {
              setState(() {
                isChecked = !isChecked;
              });
            }
          }),
    );
  }
}
