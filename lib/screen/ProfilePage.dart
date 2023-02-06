import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/model/User.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bloc/blocUser/user_bloc.dart';
import '../bloc/blocUser/user_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameControler;
  late TextEditingController emailControler;
  late TextEditingController phoneControler;
  late TextEditingController dobControler;
  late TextEditingController addressControler;
  late TextEditingController positionControler;
  late TextEditingController oldPasswordControler;
  late TextEditingController newPasswordControler;
  late TextEditingController confirmControler;

  XFile? image;
  DateTime? selectedDate;

  @override
  void initState() {
    nameControler = TextEditingController();
    emailControler = TextEditingController();
    phoneControler = TextEditingController();
    dobControler = TextEditingController();
    addressControler = TextEditingController();
    positionControler = TextEditingController();
    oldPasswordControler = TextEditingController();
    newPasswordControler = TextEditingController();
    confirmControler = TextEditingController();
    image == null;
    selectedDate = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEBFDF2),
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                if (selectedDate == null) {
                  selectedDate = state.user.dateOfBirth!.toDate();
                }
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 30, right: 16),
                      width: MediaQuery.of(context).size.width - 64 * 4,
                      height: MediaQuery.of(context).size.height - 300,
                      color: Colors.white,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Stack(children: [
                              Container(
                                  margin: EdgeInsets.only(top: 50),
                                  height: 220,
                                  width: 220,
                                  child: image == null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(state.user.image!),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(
                                              File(image!.path),
                                              scale: 1),
                                        )),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Material(
                                    color: Color(0xFFD9D9D9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        splashRadius: 25,
                                        splashColor: Colors.grey,

                                        // Update image
                                        onPressed: () async {
                                          final ImagePicker _picker =
                                              ImagePicker();
                                          // Pick an image
                                          final XFile? image =
                                              await _picker.pickImage(
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
                              width: 80,
                            ),
                            Container(
                              width: 520,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  input('Name:', nameControler,
                                      state.user.fullName!, Icons.abc),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Email:', emailControler,
                                      state.user.email!, Icons.abc),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Phone number:', phoneControler,
                                      state.user.phone!, Icons.abc),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input(
                                      'Date of birth:',
                                      dobControler,
                                      selectedDate!.day.toString() +
                                          '/' +
                                          selectedDate!.month.toString() +
                                          '/' +
                                          selectedDate!.year.toString(),
                                      Icons.calendar_month),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Address:', addressControler,
                                      state.user.address!, Icons.abc),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Position:', positionControler,
                                      state.user.position!, Icons.abc)
                                  // combobox()
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    User user = User(
                                        idUser: state.user.idUser,
                                        fullName: nameControler.text,
                                        phone: phoneControler.text,
                                        email: emailControler.text,
                                        dateOfBirth:
                                            Timestamp.fromDate(selectedDate!),
                                        salary: state.user.salary,
                                        image: state.user.image,
                                        position: state.user.position,
                                        address: addressControler.text,
                                        state: state.user.state);

                                    if (image != null) {
                                      context.read<UserBloc>().add(
                                          UpdateAvatarUser(
                                              File(image!.path), user));
                                    } else
                                      context
                                          .read<UserBloc>()
                                          .add(UpdateUser(user));
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
                                  },
                                  child: Text(
                                    'Save ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  style: ButtonStyle(
                                      maximumSize: MaterialStateProperty.all(
                                          Size(120, 60)),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 32)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF226B3F))),
                                ),
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 64 * 4,
                      height: 200,
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Change password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Row(
                                children: [
                                  // inputPassword(
                                  //     'Old password', oldPasswordControler),
                                  inputPassword(
                                      'New password', newPasswordControler),
                                  inputPassword(
                                      'Confirm password', confirmControler),
                                ],
                              ),
                            )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (newPasswordControler.text ==
                                          confirmControler.text &&
                                      newPasswordControler.text != '') {
                                    context.read<UserBloc>().add(
                                        ChangePasswordUser(
                                            password: newPasswordControler.text,
                                            context: context));
                                    newPasswordControler.clear();
                                    confirmControler.clear();
                                  } else {
                                    _showDialog(context,
                                        'Please check password and confirm password again');
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ButtonStyle(
                                    // maximumSize:
                                    //     MaterialStateProperty.all(Size(110, 60)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 32)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF226B3F))),
                              ),
                            )
                          ]),
                    ),
                  ],
                );
              } else
                return Container();
            },
          ),
        ),
      )),
    );
  }

  Flexible inputPassword(text, TextEditingController controller) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Text(text + ':'),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                controller: controller,
                // obscureText: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

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
      });
  }

  Row input(
      label, TextEditingController controller, String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
            child: Container(
          width: 350,
          child: TextField(
            controller: controller..text = text,
            // obscureText: true,
            readOnly: icon != Icons.abc || label == 'Position:',
            decoration: InputDecoration(
              suffixIcon: icon != Icons.abc
                  ? IconButton(
                      icon: Icon(icon),
                      onPressed: () {
                        // _restorableDatePickerRouteFuture.present();
                        _selectDate(context);
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
        ))
      ],
    );
  }

  // Row combobox() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         'Position:',
  //         style: TextStyle(fontSize: 18),
  //       ),
  //       SizedBox(
  //         width: 20,
  //       ),
  //       Container(
  //         height: 48,
  //         width: 350,
  //         child: Padding(
  //           padding: EdgeInsets.only(bottom: 0),
  //           child: DropdownButtonFormField2(
  //             decoration: InputDecoration(
  //               // hintText: 'Choose one',
  //               //Add isDense true and zero Padding.
  //               //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
  //               isDense: true,
  //               contentPadding: EdgeInsets.zero,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               //Add more decoration as you want here
  //               //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
  //             ),
  //             isExpanded: true,
  //             hint: const Text(
  //               'Choose one',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             icon: const Icon(
  //               Icons.arrow_drop_down,
  //               color: Colors.black45,
  //             ),
  //             value: position,
  //             iconSize: 30,
  //             buttonHeight: 60,
  //             buttonPadding: const EdgeInsets.only(left: 0, right: 10),
  //             dropdownDecoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             items: listPosition
  //                 .map((item) => DropdownMenuItem<String>(
  //                       value: item,
  //                       child: Text(
  //                         item,
  //                         style: const TextStyle(
  //                           fontSize: 18,
  //                         ),
  //                       ),
  //                     ))
  //                 .toList(),
  //             validator: (value) {
  //               if (value == null) {
  //                 return 'Please select gender.';
  //               }
  //             },
  //             onChanged: (value) {
  //               //Do something when changing the item if you want.
  //               position = value.toString();
  //             },
  //             onSaved: (value) {
  //               position = value.toString();
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _showDialog(BuildContext context, String content) {
    // status: false: error, true: success
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Notification'),
        content: Text(content),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text(
          //     'Cancel',
          //     style: TextStyle(color: Colors.black),
          //   ),
          // ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
