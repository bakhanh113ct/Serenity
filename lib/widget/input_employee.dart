import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputEmployee extends StatelessWidget {
  const InputEmployee({
    Key? key,
    required this.text,
    required this.controller,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
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
            TextFormField(
              obscureText: text == 'Password',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (text == 'Salary') {
                    // controller.text = value;
                    final format = NumberFormat("###,###.###", "tr_TR");
                    controller.text =
                        format.format(int.parse(value.replaceAll('.', '')));
                    controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length));
                  }
                }
              },
              keyboardType: text == 'Salary' ||
                      text == 'Phone number' ||
                      text == 'Amount' ||
                      text == 'Price' ||
                      text == 'Historical Cost'
                  ? TextInputType.number
                  : text == 'Email'
                      ? TextInputType.emailAddress
                      : TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter ' + text;
              },
              readOnly:
                  icon == Icons.calendar_month || icon == Icons.abc_outlined,
              onTap: icon == Icons.calendar_month
                  ? () {
                      print('can\'t edit');
                    }
                  : () {},
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: icon != Icons.abc && icon != Icons.abc_outlined
                    ? IconButton(
                        icon: Icon(icon),
                        onPressed: () {
                          // _selectDate(context);
                          onPress();
                        },
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
