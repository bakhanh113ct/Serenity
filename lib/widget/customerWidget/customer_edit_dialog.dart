// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import '../../bloc/blocCustomer/customer_event.dart';
import '../../bloc/blocCustomer/customer_repository.dart';
import '../../model/Customer.dart';
import 'package:date_field/date_field.dart';
class CustomerEditDialog extends StatefulWidget {
  const CustomerEditDialog({
    Key? key,
    required this.idCustomer,
    required this.title,
    required this.isEdit,
  }) : super(key: key);
  final String idCustomer;
  final String title;
  final bool isEdit;
  @override
  State<CustomerEditDialog> createState() => _CustomerEditDialogState();
}

class _CustomerEditDialogState extends State<CustomerEditDialog> {
  XFile? imageAvatar;

  String  defaultImage = 'https://firebasestorage.googleapis.com/v0/b/serenity-8fd4f.appspot.com/o/4043232-avatar-batman-comics-hero_113278.png?alt=media&token=2e58b0ea-2708-4269-83aa-1f1f60d0ac15';
  var initValues = {
    'name': '',
    'address': '',
    'phone': '',
    'email': '',
    'dateOfBirth': Timestamp.now(),
    'image': '',
  };
  var editCustomer = Customer(
      idCustomer: '',
      name: '',
      address: '',
      email: '',
      phone: '',
      dateOfBirth: Timestamp.now(),
      image: '');
  final _form = GlobalKey<FormState>();
  var isLoading = true;
  void _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (editCustomer.idCustomer == '') {
      //add customer
      if(imageAvatar == null){
        editCustomer = editCustomer.copyWith(image: defaultImage);
      } else{
       String image = await CustomerRepository().uploadAndGetImageUrl(imageAvatar);
       editCustomer = editCustomer.copyWith(image: image);       
      }
      if (!mounted) return;
      context.read<CustomerBloc>().add(AddCustomer(customer: editCustomer));
      const snackBar = SnackBar(
        content: Text('Add Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      // update customer
      if(imageAvatar == null ){
        editCustomer = editCustomer.image!.isEmpty ? editCustomer.copyWith(image: defaultImage) : editCustomer;
      } else{
       String image = await CustomerRepository().uploadAndGetImageUrl(imageAvatar);
       editCustomer = editCustomer.copyWith(image: image);       
      }
      if (!mounted) return;
      context.read<CustomerBloc>().add(UpdateCustomer(customer: editCustomer));
      const snackBar = SnackBar(
        content: Text('Update Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void pickImageFromDevice() async {
    if(!widget.isEdit) return;
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageAvatar = img;
    });
  }

  void pickImageFromCamera() async {
    if (!widget.isEdit) return;
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
  void didChangeDependencies() async {
    if(!mounted) return;
    if (widget.idCustomer == '') {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final listCustomers = await CustomerRepository().get();
    editCustomer = listCustomers
        .firstWhere((element) => element.idCustomer == widget.idCustomer);
    initValues = {
      'name': editCustomer.name!,
      'address': editCustomer.address!,
      'phone': editCustomer.phone!,
      'email': editCustomer.email!,
      'image': editCustomer.image!,
      'dateOfBirth': editCustomer.dateOfBirth!,
    };
    if(!mounted) return;
       setState(() {
        isLoading = false;
      });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator(),) : AlertDialog(
      actions: [
        !widget.isEdit ? Center(
          child: Container(
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
        ) : Row(
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
                                            backgroundColor: Colors.white,
                                              backgroundImage: editCustomer.image!.isEmpty ? NetworkImage(
                                                  defaultImage) : NetworkImage(editCustomer.image!) ,
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
                              idCustomer: editCustomer.idCustomer,
                              name: value!,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              image: editCustomer.image);
                        },
                        enabled: widget.isEdit,
                      ),
                       const SizedBox(
                        height: 10,
                      ),
                      DateTimeFormField(
                        initialDate: (initValues['dateOfBirth']! as Timestamp).toDate() ,
                        decoration: const InputDecoration(
                            labelText: 'Date Of Birth', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_month)), 
                        mode: DateTimeFieldPickerMode.date, 
                        initialValue: (initValues['dateOfBirth']! as Timestamp).toDate(),               
                        onSaved: (value) {
                          editCustomer = Customer(
                              idCustomer: editCustomer.idCustomer,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: Timestamp.fromDate(value!),
                              image: editCustomer.image);
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
                        enabled: widget.isEdit,
                        onSaved: (value) {
                          editCustomer = Customer(
                              idCustomer: editCustomer.idCustomer,
                              name: editCustomer.name,
                              address: value!,
                              email: editCustomer.email,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              image: editCustomer.image);
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
                        enabled: widget.isEdit,
                        onSaved: (value) {
                          editCustomer = Customer(
                              idCustomer: editCustomer.idCustomer,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: value!,
                              phone: editCustomer.phone,
                              dateOfBirth: editCustomer.dateOfBirth,
                              image: editCustomer.image);
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
                              idCustomer: editCustomer.idCustomer,
                              name: editCustomer.name,
                              address: editCustomer.address,
                              email: editCustomer.email,
                              phone: value!,
                              dateOfBirth: editCustomer.dateOfBirth,
                              image: editCustomer.image);
                        },
                        enabled: widget.isEdit,
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
