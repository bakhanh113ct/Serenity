import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/model/User.dart';
import 'package:serenity/widget/input_employee.dart';

import '../bloc/employee/employee_bloc.dart';

class ModalAddEmployee extends StatefulWidget {
  const ModalAddEmployee({
    Key? key,
  }) : super(key: key);
  @override
  State<ModalAddEmployee> createState() => _ModalAddEmployeeState();
}

class _ModalAddEmployeeState extends State<ModalAddEmployee> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;
  late TextEditingController salaryController;

  XFile? image;
  late List<TextEditingController> listController;
  String? selectedValue;
  bool error = false;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  void initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    addressController = new TextEditingController();
    phoneController = new TextEditingController();
    dobController = new TextEditingController();
    passwordController = new TextEditingController();
    salaryController = new TextEditingController();

    listController = [
      nameController,
      emailController,
      addressController,
      phoneController,
      dobController,
      passwordController,
      salaryController,
    ];

    selectedValue = genderItems[1];
    selectedDate = DateTime.now();
    image = null;

    super.initState();
  }

  final List<String> genderItems = [
    'Admin',
    'Staff',
  ];

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dobController.text = picked.day.toString() +
            '/' +
            picked.month.toString() +
            '/' +
            picked.year.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 600,
          width: 600,
          child: Column(
            children: [
              Expanded(
                child: Row(children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(children: [
                        image == null
                            ? Container(
                                // margin: EdgeInsets.only(top: 50),
                                height: 170,
                                width: 170,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/serenity-8fd4f.appspot.com/o/user.png?alt=media&token=e7581652-8c21-4952-aeb9-72a37922c6c7'),
                                ))
                            : Container(
                                // margin: EdgeInsets.only(top: 50),
                                height: 170,
                                width: 170,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(File(image!.path)),
                                )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Material(
                              color: const Color(0xFFD9D9D9),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  splashRadius: 25,
                                  splashColor: Colors.grey,
                                  onPressed: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    // Pick an image
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (image == null) return;
                                    setState(() {
                                      this.image = image;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                            ))
                      ]),
                      const SizedBox(
                        height: 14,
                      ),
                      InputEmployee(
                        text: 'Phone number',
                        controller: phoneController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                      InputEmployee(
                        text: 'Date of birth',
                        controller: dobController,
                        icon: Icons.calendar_month,
                        onPress: () {
                          _selectDate(context);
                        },
                      ),
                      InputEmployee(
                        text: 'Salary',
                        controller: salaryController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      InputEmployee(
                        text: 'Name',
                        controller: nameController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                      InputEmployee(
                        text: 'Email',
                        controller: emailController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                      InputEmployee(
                        text: 'Address',
                        controller: addressController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                      InputEmployee(
                        text: 'Password',
                        controller: passwordController,
                        icon: Icons.abc,
                        onPress: () {},
                      ),
                      combobox(),
                    ],
                  )),
                ]),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text(
                      'Cancle ',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        maximumSize:
                            MaterialStateProperty.all(const Size(110, 60)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15)),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF226B3F))),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              !listController
                                  .any((element) => element.text == '') &&
                              image != null &&
                              selectedValue != null) {
                            User user = User(
                              fullName: nameController.text,
                              address: addressController.text,
                              dateOfBirth: Timestamp.fromDate(selectedDate!),
                              email: emailController.text,
                              idUser: 'idUser',
                              image: image!.path,
                              phone: phoneController.text,
                              position: selectedValue,
                              salary: int.tryParse(
                                  salaryController.text.toString()),
                            );
                            context.read<EmployeeBloc>().add(AddEmployee(
                                user: user, password: passwordController.text));
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 300, vertical: 16),
                              borderRadius: BorderRadius.circular(8),
                              flushbarStyle: FlushbarStyle.FLOATING,
                              title: 'Notification',
                              message: 'Create user successful',
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          } else {
                            debugPrint('điền đầy đủ thông tin');
                          }
                        },
                        child: const Text(
                          'Save ',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                            maximumSize:
                                MaterialStateProperty.all(const Size(110, 60)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF226B3F))),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding combobox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Position',
            style: TextStyle(fontSize: 18),
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
                  // hintText: 'Choose one',
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
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
                value: genderItems[1],
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
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
                    return 'Please select gender.';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  selectedValue = value.toString();
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
