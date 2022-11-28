import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/model/User.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bloc/blocUser/user_bloc.dart';

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
                                      state.user.fullName!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Email:', emailControler,
                                      state.user.email!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Phone number:', phoneControler,
                                      state.user.phone!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Date of birth:', dobControler,
                                      state.user.dateOfBirth!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Address:', addressControler,
                                      state.user.address!),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  input('Position:', positionControler,
                                      state.user.position!)
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
                                      dateOfBirth: dobControler.text,
                                      salary: state.user.salary,
                                      image: state.user.image,
                                      position: state.user.position,
                                      address: addressControler.text,
                                    );

                                    if (image != null) {
                                      context.read<UserBloc>().add(
                                          UpdateAvatarUser(
                                              File(image!.path), user));
                                    } else
                                      context
                                          .read<UserBloc>()
                                          .add(UpdateUser(user));
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

  Row input(label, TextEditingController controller, text) {
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

            decoration: InputDecoration(
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
