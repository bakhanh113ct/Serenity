import 'dart:io';

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
  late TextEditingController positionController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;
  late TextEditingController salaryController;
  XFile? image;
  late List<TextEditingController> listController;
  @override
  void initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    addressController = new TextEditingController();
    positionController = new TextEditingController();
    phoneController = new TextEditingController();
    dobController = new TextEditingController();
    passwordController = new TextEditingController();
    salaryController = new TextEditingController();
    image = null;
    listController = [
      nameController,
      emailController,
      addressController,
      phoneController,
      dobController,
      passwordController,
      salaryController,
    ];
    super.initState();
  }

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 600,
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
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/serenity-8fd4f.appspot.com/o/4043232-avatar-batman-comics-hero_113278.png?alt=media&token=2e58b0ea-2708-4269-83aa-1f1f60d0ac15'),
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
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                splashRadius: 25,
                                splashColor: Colors.grey,
                                onPressed: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  // Pick an image
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image == null) return;
                                  setState(() {
                                    this.image = image;
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                )),
                          ))
                    ]),
                    SizedBox(
                      height: 39,
                    ),
                    InputEmployee(
                        text: 'Phone number', controller: phoneController),
                    InputEmployee(
                      text: 'Date of birth',
                      controller: dobController,
                    ),
                    InputEmployee(
                      text: 'Salary',
                      controller: salaryController,
                    ),
                  ],
                )),
                Expanded(
                    child: Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0,
                      ),
                      InputEmployee(
                        text: 'Name',
                        controller: nameController,
                      ),
                      InputEmployee(
                        text: 'Email',
                        controller: emailController,
                      ),
                      InputEmployee(
                        text: 'Address',
                        controller: addressController,
                      ),
                      // InputEmployee(
                      //   text: 'Position',
                      //   controller: positionController,
                      // ),
                      combobox(),
                      InputEmployee(
                        text: 'Password',
                        controller: passwordController,
                      ),
                    ],
                  ),
                )),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text(
                    'Cancle ',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                      maximumSize: MaterialStateProperty.all(Size(110, 60)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF226B3F))),
                ),
                SizedBox(
                  width: 20,
                ),
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context, 'Cancel');
                        if (!listController
                                .any((element) => element.text == '') &&
                            image != null &&
                            selectedValue != null) {
                          User user = User(
                            fullName: nameController.text,
                            address: addressController.text,
                            dateOfBirth: dobController.text,
                            email: emailController.text,
                            idUser: 'aa',
                            image: image!.path,
                            phone: phoneController.text,
                            position: positionController.text,
                            salary:
                                int.tryParse(salaryController.text.toString()),
                          );
                          context
                              .read<EmployeeBloc>()
                              .add(AddEmployee(user: user));
                        } else {
                          debugPrint('điền đầy đủ thông tin');
                        }
                      },
                      child: Text(
                        'Save ',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                          maximumSize: MaterialStateProperty.all(Size(110, 60)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF226B3F))),
                    );
                  },
                ),
              ],
            )
          ],
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
          Text(
            'Position',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 75,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
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
                  '',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
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
