import 'package:flutter/material.dart';

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
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              obscureText: text == 'Password',
              keyboardType:
                  text == 'Salary' || text == 'Phone number' || text == 'Amount'
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
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
