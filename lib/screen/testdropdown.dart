import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class TestDropDown extends StatefulWidget {
  const TestDropDown({super.key});

  @override
  State<TestDropDown> createState() => _TestDropDownState();
}

class _TestDropDownState extends State<TestDropDown> {
  Future<List<String>> getAllCategory() async {
    CollectionReference docs =
        await FirebaseFirestore.instance.collection('test');
    return docs.get().then(
        (value) => value.docs.map((e) => e.get('name').toString()).toList());
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getAllCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const SizedBox();
              }
              List<String> temp = List.from(snapshot.data!);
              return Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: DropdownButton2(
                  // decoration: InputDecoration(
                  //   isDense: true,
                  //   contentPadding: EdgeInsets.zero,
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   focusedBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black),
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  // ),
                  isExpanded: true,
                  hint: const Text(
                    'Choose one',
                    style: TextStyle(fontSize: 18),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  value: selectedValue,
                  // value: 'ngoc',
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: temp
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
                  // validator: (value) {
                  //   if (value == null) {}
                  // },
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  // onSaved: (value) {},
                ),
              );
            }),
      ),
    );
  }
}
