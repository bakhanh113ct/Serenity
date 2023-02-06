import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/User.dart' as model_user;
import 'package:serenity/widget/input_employee.dart';

import '../bloc/blocUser/user_bloc.dart';
import '../bloc/blocUser/user_state.dart';
import '../bloc/employee/employee_bloc.dart';

class ModalEditEmployee extends StatefulWidget {
  const ModalEditEmployee({
    Key? key,
    required this.user,
  }) : super(key: key);
  final model_user.User user;
  @override
  State<ModalEditEmployee> createState() => _ModalEditEmployeeState();
}

class _ModalEditEmployeeState extends State<ModalEditEmployee> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  // late TextEditingController passwordController;
  late TextEditingController salaryController;

  XFile? image;
  late List<TextEditingController> listController;
  String? positionValue;
  String? stateValue;
  bool error = false;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  void initState() {
    final format = NumberFormat("###,###.###", "tr_TR");
    nameController = TextEditingController()..text = widget.user.fullName!;
    emailController = TextEditingController()..text = widget.user.email!;
    addressController = TextEditingController()..text = widget.user.address!;
    phoneController = TextEditingController()..text = widget.user.phone!;
    dobController = TextEditingController()
      ..text =
          '${widget.user.dateOfBirth!.toDate().day}/${widget.user.dateOfBirth!.toDate().month}/${widget.user.dateOfBirth!.toDate().year}/';
    // passwordController = TextEditingController()..text = '';
    final format = NumberFormat("###,###.###", "tr_TR");
    salaryController = TextEditingController()
      ..text = format.format(widget.user.salary).toString();

    listController = [
      nameController,
      emailController,
      addressController,
      phoneController,
      dobController,
      salaryController,
    ];

    positionValue = widget.user.position;
    stateValue = widget.user.state;
    selectedDate = widget.user.dateOfBirth!.toDate();
    image = null;

    super.initState();
  }

  final List<String> stateItems = ['active', 'inactive'];
  final List<String> positionItems = [
    'admin',
    'staff',
  ];

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 620,
          width: 600,
          child: Column(
            children: [
              Expanded(
                child: Row(children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(children: [
                        image == null
                            ? Container(
                                // margin: EdgeInsets.only(top: 50),
                                height: 180,
                                width: 180,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(widget.user.image!),
                                ))
                            : Container(
                                // margin: EdgeInsets.only(top: 50),
                                height: 180,
                                width: 180,
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
                        height: 39,
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
                      // InputEmployee(
                      //   text: 'Position',
                      //   controller: positionController,
                      // ),
                      // InputEmployee(
                      //   text: 'Password',
                      //   controller: passwordController,
                      //   icon: Icons.abc,
                      //   onPress: () {},
                      // ),
                      comboBox('State'),

                      comboBox('Position'),
                    ],
                  )),
                ]),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<EmployeeBloc>()
                            .add(ResetPassword(email: widget.user.email!));
                        Flushbar(
                          flushbarPosition: FlushbarPosition.TOP,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 300, vertical: 16),
                          borderRadius: BorderRadius.circular(8),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          title: 'Notification',
                          message:
                              'To reset your password, an email was sent to email address ${widget.user.email}',
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      },
                      style: ButtonStyle(
                          // maximumSize: MaterialStateProperty.all(Size(110, 60)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 15)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF226B3F))),
                      child: const Text(
                        'Reset Password ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor, // red as border color
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                            },
                            style: ButtonStyle(
                              // maximumSize:
                              //     MaterialStateProperty.all(Size(110, 60)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 15)),
                              // backgroundColor: MaterialStateProperty.all(
                              //     const Color(0xFF226B3F)),
                            ),
                            child: const Text(
                              'Cancle ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
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
                                    positionValue != null) {
                                  final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                                  if (!emailValid) {
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 300, vertical: 16),
                                      borderRadius: BorderRadius.circular(8),
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      title: 'Notification',
                                      message: 'Check email address again',
                                      duration: const Duration(seconds: 3),
                                    ).show(context);
                                    return;
                                  }
                                  model_user.User user = model_user.User(
                                      fullName: nameController.text,
                                      address: addressController.text,
                                      dateOfBirth:
                                          Timestamp.fromDate(selectedDate!),
                                      email: emailController.text,
                                      idUser: widget.user.idUser,
                                      image: image != null
                                          ? image!.path
                                          : widget.user.image,
                                      phone: phoneController.text,
                                      position: positionValue,
                                      salary: int.tryParse(salaryController.text
                                          .replaceAll('.', '')),
                                      state: stateValue);
                                  context
                                      .read<EmployeeBloc>()
                                      .add(UpdateEmployee(user: user));
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 300, vertical: 16),
                                    borderRadius: BorderRadius.circular(8),
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                    title: 'Notification',
                                    message: 'Update information successful',
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  // debugPrint('điền đầy đủ thông tin');
                                }
                              },
                              style: ButtonStyle(
                                  // maximumSize:
                                  //     MaterialStateProperty.all(Size(110, 60)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 32)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF226B3F))),
                              child: const Text(
                                'Save ',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                value: text == 'Position' ? positionValue : stateValue,
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: text == 'Position'
                    ? positionItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ))
                        .toList()
                    : stateItems
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
                  if (text == 'Position') {
                    positionValue = value.toString();
                  } else {
                    stateValue = value.toString();
                  }
                },
                onSaved: (value) {
                  if (text == 'Position') {
                    positionValue = value.toString();
                  } else {
                    stateValue = value.toString();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
