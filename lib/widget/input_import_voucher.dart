import 'package:flutter/material.dart';

class InputImportVoucher extends StatelessWidget {
  const InputImportVoucher(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.onPress,
      required this.textInputType});
  final String text;
  final IconData icon;
  final TextEditingController controller;
  final Function onPress;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            keyboardType: textInputType,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter ' + text;
            },
            readOnly: icon == Icons.calendar_month,
            onTap: icon == Icons.calendar_month
                ? () {
                    print('can\'t edit');
                  }
                : () {},
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: icon != Icons.abc
                  ? IconButton(
                      icon: Icon(icon),
                      onPressed: () {
                        // _selectDate(context);
                        onPress();
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    );
  }
}
