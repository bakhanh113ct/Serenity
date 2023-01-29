// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocCustomer/customer_repository.dart';
import 'package:serenity/bloc/blocReportTrouble/report_trouble_repository.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/Customer.dart';
import '../../bloc/blocTrouble/trouble_repository.dart';
import '../../bloc/blocUser/user_repository.dart';
import '../../model/User.dart';
import '../../model/report_trouble.dart';
import '../../model/trouble.dart';

enum SignaturePerson { customer, staff }

class ReportTroubleEditDialog extends StatefulWidget {
  const ReportTroubleEditDialog({
    Key? key,
    required this.idReportTrouble,
    required this.idTrouble,
    required this.title,
    required this.isEdit,
  }) : super(key: key);
  final String idReportTrouble;
  final String idTrouble;
  final String title;
  final bool isEdit;
  @override
  State<ReportTroubleEditDialog> createState() =>
      _ReportTroubleEditDialogState();
}

class _ReportTroubleEditDialogState extends State<ReportTroubleEditDialog> {
  var editReportTrouble = ReportTrouble(
      idTrouble: '',
      idReportTrouble: '',
      idStaff: '',
      idCustomer: '',
      dateCreated: Timestamp.now(),
      dateSolved: '',
      totalMoney: '',
      isCompensate: false,
      status: '',
      signCus: '',
      signStaff: '');
  var listCustomers = <Customer>[];
  var user = User();
  var customer = Customer();
  var trouble = Trouble();
  var reportTrouble = ReportTrouble();
  String compensation = 'compensate';
  bool isAgreeCompensation = false;
  XFile? signCus;
  XFile? signStaff;
  int totalMoney = 0;
  final _form = GlobalKey<FormState>();
  var isLoading = true;

  // save the form
  void _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (!isAgreeCompensation) {
      return;
    }
    _form.currentState!.save();
    if (widget.idReportTrouble == '') {
      if (signCus == null || signStaff == null) {
        return;
      }
      var imageCus =
          await ReportTroubleRepository().uploadAndGetSignature(signCus);
      var imageStaff =
          await ReportTroubleRepository().uploadAndGetSignature(signStaff);
      //add ReportTrouble
      editReportTrouble = editReportTrouble.copyWith(
        idTrouble: widget.idTrouble,
        idCustomer: customer.idCustomer,
        dateCreated: Timestamp.fromDate(DateTime.now()),
        dateSolved: '',
        totalMoney: totalMoney.toString(),
        isCompensate: compensation == 'compensate' ? true : false,
        status: 'Pending',
        idStaff: user.idUser,
        signCus: imageCus,
        signStaff: imageStaff,
      );
      if (!mounted) return;
      context
          .read<TroubleBloc>()
          .add(UpdateTrouble(trouble: trouble.copyWith(status: 'Reported', dateSolved: DateFormat('dd-MM-yyyy hh:mm:ss aa').format(DateTime.now()))));
      context
          .read<ReportTroubleBloc>()
          .add(AddReportTrouble(reportTrouble: editReportTrouble));
      const snackBar = SnackBar(
        content: Text('Add Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String? imageCus, imageStaff;
      if(signCus != null) {
        imageCus =
            await ReportTroubleRepository().uploadAndGetSignature(signCus);
      }
      if (signStaff != null) {
        imageStaff =
            await ReportTroubleRepository().uploadAndGetSignature(signStaff);
      }
      // update ReportTrouble
      editReportTrouble = editReportTrouble.copyWith(
        idTrouble: widget.idTrouble,
        idCustomer: customer.idCustomer,
        dateCreated: Timestamp.fromDate(DateTime.now()),
        dateSolved: '',
        totalMoney: totalMoney.toString(),
        isCompensate: compensation == 'compensate' ? true : false,
        status: 'Pending',
        idStaff: user.idUser,
        signCus: imageCus ?? reportTrouble.signCus,
        signStaff: imageStaff ?? reportTrouble.signStaff,
        idReportTrouble: reportTrouble.idReportTrouble,
      );
      if (!mounted) return;
      context
          .read<ReportTroubleBloc>()
          .add(UpdateReportTrouble(reportTrouble: editReportTrouble));
      const snackBar = SnackBar(
        content: Text('Update Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void pickImageFromDevice(SignaturePerson signature) async {
    if (!widget.isEdit) return;
    if (signature == SignaturePerson.customer) {
      final ImagePicker picker = ImagePicker();
      final img = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        signCus = img;
      });
    } else if (signature == SignaturePerson.staff) {
      final ImagePicker picker = ImagePicker();
      final img = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        signStaff = img;
      });
    }
  }

  void pickImageFromCamera(SignaturePerson signature) async {
    if (!widget.isEdit) return;
    if (signature == SignaturePerson.customer) {
      final ImagePicker picker = ImagePicker();
      final img = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        signCus = img;
      });
    } else if (signature == SignaturePerson.staff) {
      final ImagePicker picker = ImagePicker();
      final img = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        signStaff = img;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    listCustomers = await CustomerRepository().get();
    trouble = await TroubleRepository().getTrouble(widget.idTrouble);
    if (widget.idReportTrouble == '') {
      user = await UserRepository().getUser();
    } else {
      reportTrouble = await ReportTroubleRepository()
          .getReportTrouble(widget.idReportTrouble);
      user = await UserRepository().getUserByIdUser(reportTrouble.idStaff!);
      compensation =
          reportTrouble.isCompensate! ? 'compensate' : 'beCompensated';
      totalMoney = int.parse(reportTrouble.totalMoney!);
      isAgreeCompensation = true;
    }
    customer = await CustomerRepository().getCustomer(trouble.idCustomer!);
  if (!mounted) return;
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AlertDialog(
            actions: [
              !widget.isEdit
                  ? Center(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, // red as bCustomer color
                          ),
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor, // red as bCustomer color
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
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Form(
                      key: _form,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                    leading: Icon(
                                      Icons.people,
                                      color: CustomColor.second,
                                    ),
                                    title: Text(
                                      'Participants',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ))),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: ListTile(
                                      title: _customerInfo(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: ListTile(
                                      title: _userInfo(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                    leading: Icon(
                                      Icons.description,
                                      color: CustomColor.second,
                                    ),
                                    title: Text(
                                      'Contents',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, bottom: 20),
                              // height: 200,
                              width: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '- The trouble occurred at the time: ${DateFormat('dd-MM-yyyy hh:mm').format(trouble.dateCreated!.toDate())}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '- The description about trouble: \n\t${trouble.description}'),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Solution:'),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: RadioListTile(
                                                  title:
                                                      const Text("Compensate"),
                                                  value: "compensate",
                                                  groupValue: compensation,
                                                  onChanged: (value) {
                                                    if (!widget.isEdit) return;
                                                    setState(() {
                                                      compensation =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: RadioListTile(
                                                  title: const Text(
                                                      "Be Compensated"),
                                                  value: "beCompensated",
                                                  groupValue: compensation,
                                                  onChanged: (value) {
                                                    if (!widget.isEdit) return;
                                                    setState(() {
                                                      compensation =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                child: const Text(
                                                    'Input total money for compensation:')),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: ListTile(
                                                trailing: const Text('VND'),
                                                title: TextFormField(
                                                    readOnly: !widget.isEdit,
                                                   
                                                    autovalidateMode:
                                                        AutovalidateMode.always,
                                                    initialValue:
                                                        totalMoney.toString(),
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Total Money',
                                                            border:
                                                                OutlineInputBorder()),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please provide a total.';
                                                      }
                                                      if (int.tryParse(value) ==
                                                          null) {
                                                        return 'Please provide a total money.';
                                                      }
                                                      if (int.parse(value) <=
                                                          0) {
                                                        return 'Please provide a total money > 0.';
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      if (int.tryParse(value) ==
                                                          null) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        totalMoney =
                                                            int.parse(value);
                                                      });
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  child: Checkbox(
                                                      value:
                                                          isAgreeCompensation,
                                                      onChanged: ((value) {
                                                        if(!widget.isEdit) return;
                                                        setState(() {
                                                          isAgreeCompensation =
                                                              value!;
                                                        });
                                                      })),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                    child: const Text(
                                                        'Tick the check box if the customer agrees with the compensation solution')),
                                              ],
                                            ),
                                            (!isAgreeCompensation
                                                ? const Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        'Tick here to confirm',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ))
                                                : const Text(''))
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                    leading: Icon(
                                      Icons.drive_file_rename_outline,
                                      color: CustomColor.second,
                                    ),
                                    title: Text(
                                      'Signature',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text('Customer'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 100,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                              ),
                                              child: signCus == null
                                                  ? (reportTrouble
                                                          .idReportTrouble == null
                                                      ? const Center(
                                                          child: Text(
                                                              'Upload Signature'))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                reportTrouble
                                                                    .signCus!),
                                                          )))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      child: Image(
                                                        fit: BoxFit.cover,
                                                        image: FileImage(File(
                                                            signCus!.path)),
                                                      ),
                                                    ),
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () =>
                                                          pickImageFromDevice(
                                                              SignaturePerson
                                                                  .customer),
                                                      icon: const Icon(
                                                        Icons.image,
                                                        size: 30,
                                                      )),
                                                  IconButton(
                                                      onPressed: () =>
                                                          pickImageFromCamera(
                                                              SignaturePerson
                                                                  .customer),
                                                      icon: const Icon(
                                                        Icons
                                                            .camera_enhance_rounded,
                                                        size: 30,
                                                      )),
                                                ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text('Staff'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 100,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                              ),
                                              child: signStaff == null
                                                  ? (reportTrouble
                                                              .idReportTrouble ==
                                                          null
                                                      ? const Center(
                                                          child: Text(
                                                              'Upload Signature'))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                reportTrouble
                                                                    .signStaff!),
                                                          )))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      child: Image(
                                                        fit: BoxFit.cover,
                                                        image: FileImage(File(
                                                            signStaff!.path)),
                                                      ),
                                                    ),
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () =>
                                                          pickImageFromDevice(
                                                              SignaturePerson
                                                                  .staff),
                                                      icon: const Icon(
                                                        Icons.image,
                                                        size: 30,
                                                      )),
                                                  IconButton(
                                                      onPressed: () =>
                                                          pickImageFromCamera(
                                                              SignaturePerson
                                                                  .staff),
                                                      icon: const Icon(
                                                        Icons
                                                            .camera_enhance_rounded,
                                                        size: 30,
                                                      )),
                                                ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,)
                          ],
                        ),

                      ),
                    )),
              ],
            ),
          );
  }

  Widget _userInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Align(alignment: Alignment.topLeft, child: Text('Staff')),
          ListTile(
            title: Text(user.fullName!),
            subtitle: Text(
                '${(user.phone == null || user.phone!.isEmpty) ? 'No phone' : user.phone}\n${user.email!}'),
            leading: CircleAvatar(backgroundImage: NetworkImage(user.image!)),
          ),
        ],
      ),
    );
  }

  Widget _customerInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Align(alignment: Alignment.topLeft, child: Text('Customer')),
          ListTile(
            title: Text(customer.name!),
            subtitle: Text('${customer.phone!}\n${customer.email!}'),
            leading:
                CircleAvatar(backgroundImage: NetworkImage(customer.image!)),
          ),
        ],
      ),
    );
  }
}
