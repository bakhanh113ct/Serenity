// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import '../bloc/blocCustomer/customer_repository.dart';
import '../model/Customer.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
class CustomerEditDialog extends StatefulWidget {
  const CustomerEditDialog({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);
  final String id;
  final String title;
  @override
  State<CustomerEditDialog> createState() => _CustomerEditDialogState();
}

class _CustomerEditDialogState extends State<CustomerEditDialog> {
  XFile? imageAvatar;

  String  defaultImageUrl = 'https://firebasestorage.googleapis.com/v0/b/serenity-8fd4f.appspot.com/o/4043232-avatar-batman-comics-hero_113278.png?alt=media&token=2e58b0ea-2708-4269-83aa-1f1f60d0ac15';
  var initValues = {
    'name': '',
    'address': '',
    'phone': '',
    'email': '',
    'dateOfBirth': DateFormat('yyyy-MM-dd').format( DateTime.now()),
    'imageUrl': '',
  };
  var editCustomer = Customer(
      id: '',
      name: '',
      address: '',
      email: '',
      phone: '',
      dateOfBirth: '',
      imageUrl: '');
  final _form = GlobalKey<FormState>();

  void _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (editCustomer.id == '') {
      //add customer
      if(imageAvatar == null){
        editCustomer = editCustomer.copyWith(imageUrl: defaultImageUrl);
      } else{
       String imageUrl = await CustomerRepository().uploadAndGetImageUrl(imageAvatar);
       editCustomer = editCustomer.copyWith(imageUrl: imageUrl);       
      }
      if (!mounted) return;
      context.read<CustomerBloc>().add(AddCustomer(customer: editCustomer));
    } else {
      // update customer
      if(imageAvatar == null){
        editCustomer = editCustomer.copyWith(imageUrl: defaultImageUrl);
      } else{
       String imageUrl = await CustomerRepository().uploadAndGetImageUrl(imageAvatar);
       editCustomer = editCustomer.copyWith(imageUrl: imageUrl);       
      }
      if (!mounted) return;
      context.read<CustomerBloc>().add(UpdateCustomer(customer: editCustomer));
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void pickImageFromDevice() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageAvatar = img;
    });
  }

  void pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageAvatar = img;
    });
  }

  
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.id == '') {
      return;
    }
    editCustomer = BlocProvider.of<CustomerBloc>(context)
        .state
        .allCustomers
        .firstWhere((element) => element.id == widget.id);
    initValues = {
      'name': editCustomer.name,
      'address': editCustomer.address,
      'phone': editCustomer.phone,
      'email': editCustomer.email,
      'imageUrl': editCustomer.imageUrl,
      'dateOfBirth': editCustomer.dateOfBirth,
    };
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor, // red as border color
                ),
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    _saveForm(context);
                  },
                  child: const Text('Save')),
            )
          ],
        ),
      ],
      clipBehavior: Clip.none,
      content: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                        Center(
                        child: Center(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(150),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      imageAvatar == null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  defaultImageUrl),
                                              radius: 100,
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  FileImage(File(imageAvatar!.path)),
                                              radius: 100),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: pickImageFromDevice,
                                                icon: const Icon(
                                                  Icons.image,
                                                  size: 30,
                                                )),
                                            IconButton(
                                                onPressed: pickImageFromCamera,
                                                icon: const Icon(
                                                    Icons.camera_enhance_rounded, size: 30,)),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      TextFormField(
                        initialValue: initValues['name'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Name', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please provide a name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editCustomer = Customer(
                              id: editCustomer.id,
                              name: value!,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              imageUrl: editCustomer.imageUrl);
                        },
                      ),
                       const SizedBox(
                        height: 10,
                      ),
                      DateTimeFormField(
                        initialDate: DateTime.parse(initValues['dateOfBirth']!) ,
                        decoration: const InputDecoration(
                            labelText: 'Date Of Birth', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_month)), 
                        mode: DateTimeFieldPickerMode.date, 
                        initialValue: DateTime.parse(initValues['dateOfBirth']!),               
                        onSaved: (value) {
                          editCustomer = Customer(
                              id: editCustomer.id,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: DateFormat('yyyy-MM-dd').format(value!),
                              imageUrl: editCustomer.imageUrl);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initValues['address'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Address', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a address.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editCustomer = Customer(
                              id: editCustomer.id,
                              name: editCustomer.name,
                              address: value!,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              imageUrl: editCustomer.imageUrl);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initValues['email'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a email.';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Email is invalid.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editCustomer = Customer(
                              id: editCustomer.id,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: value!,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              imageUrl: editCustomer.imageUrl);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: initValues['phone'] as String,
                        decoration: const InputDecoration(
                            labelText: 'Phone', border: OutlineInputBorder()),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a phone.';
                          }
                          if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                              .hasMatch(value)) {
                            return 'Phone is invalid.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editCustomer = Customer(
                              id: editCustomer.id,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: value!,
                              dateOfBirth: editCustomer.dateOfBirth,
                              imageUrl: editCustomer.imageUrl);
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
