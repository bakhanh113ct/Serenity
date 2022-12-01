import 'package:flutter/material.dart';

class InputEmployee extends StatelessWidget {
  const InputEmployee({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;

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
              validator: (value) {
                print('object');
                return 'error';
              },
              controller: controller,
              decoration: InputDecoration(
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
