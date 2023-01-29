// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocDeliveryReceipt/delivery_receipt_repository.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/product.dart';
import 'package:serenity/repository/detail_order_repository.dart';
import '../../bloc/blocDeliveryReceipt/delivery_receipt_bloc.dart';
import '../../bloc/blocUser/user_repository.dart';
import '../../model/User.dart';
import '../../model/delivery_receipt.dart';
import '../../model/detail_order.dart';
import '../../model/order.dart';
import 'export_product_list.dart';

enum SignaturePerson { staff }

class DeliveryReceiptEditDialog extends StatefulWidget {
  const DeliveryReceiptEditDialog({
    Key? key,
    required this.idDeliveryReceipt,
    required this.title,
    required this.isEdit,
    required this.order,
  }) : super(key: key);
  final String idDeliveryReceipt;
  final String title;
  final bool isEdit;
  final MyOrder order;
  @override
  State<DeliveryReceiptEditDialog> createState() =>
      _DeliveryReceiptEditDialogState();
}

class _DeliveryReceiptEditDialogState extends State<DeliveryReceiptEditDialog> {
  var editDeliveryReceipt = DeliveryReceipt(
      idDeliveryReceipt: '',
      idStaff: '',
      totalMoney: '',
      idOrder: '',
      dateCreated: Timestamp.now(),
      listProducts: <Product>[],
      nameCustomer: '',
      signStaff: '');
  var user = User();
  var deliveryReceipt = DeliveryReceipt();
  var listDetailOrder = <DetailOrder>[];
  XFile? signStaff;
  final _form = GlobalKey<FormState>();
  var isLoading = true;
  var totalMoney = 0.0;
  // save the form
  void _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (widget.idDeliveryReceipt == '') {
      if (signStaff == null) {
        return;
      }
      var imageStaff = await DeliveryReceiptRepository()
          .uploadSignDeliveryReceipt(signStaff);
      var listProducts = <Product>[];
      listDetailOrder.forEach((element) async {
        var product = await ImportBookRepository()
            .getProductImportBook(element.idProduct!);
        listProducts.add(product.copyWith(amount: element.amount));
      });
      // add DeliveryReceipt
      editDeliveryReceipt = editDeliveryReceipt.copyWith(
        idOrder: widget.order.idOrder,
        dateCreated: Timestamp.fromDate(DateTime.now()),
        totalMoney: totalMoney.toString(),
        idStaff: user.idUser,
        signStaff: imageStaff,
        idDeliveryReceipt: editDeliveryReceipt.idDeliveryReceipt,
        nameCustomer: widget.order.nameCustomer,
        listProducts: listProducts,
      );
      if (!mounted) return;
      context
          .read<DeliveryReceiptBloc>()
          .add(AddDeliveryReceipt(deliveryReceipt: editDeliveryReceipt));
      const snackBar = SnackBar(
        content: Text('Add Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String? imageStaff;
      if (signStaff != null) {
        imageStaff = await DeliveryReceiptRepository()
            .uploadSignDeliveryReceipt(signStaff);
      }

      if (!mounted) return;
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
    if (signature == SignaturePerson.staff) {
      final ImagePicker picker = ImagePicker();
      final img = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        signStaff = img;
      });
    }
  }

  void pickImageFromCamera(SignaturePerson signature) async {
    if (!widget.isEdit) return;
    if (signature == SignaturePerson.staff) {
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
    if (!mounted) return;
    if (widget.idDeliveryReceipt.isNotEmpty) {
      deliveryReceipt = await DeliveryReceiptRepository()
          .getDeliveryReceipt(widget.idDeliveryReceipt);
      user = await UserRepository().getUserByIdUser(deliveryReceipt.idStaff!);
      editDeliveryReceipt =
          editDeliveryReceipt.copyWith(idOrder: deliveryReceipt.idOrder);
    } else {
      user = await UserRepository().getUser();
    }

    listDetailOrder = await DetailOrderRepository()
            .getListDetailOrder(widget.order.idOrder!);

    listDetailOrder.forEach(((element) {
      totalMoney += double.parse(element.price!);
    }));

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
                                      Icons.import_contacts,
                                      color: CustomColor.second,
                                    ),
                                    title: Text(
                                      'Order',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ))),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: ListTile(
                                      title: _importOrderInfo(),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container())
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
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            '- Documents will confirm the export of goods from the warehouse for selling'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '- Time confirmation: ${widget.idDeliveryReceipt.isNotEmpty ? DateFormat('dd-MM-yyyy').format(deliveryReceipt.dateCreated!.toDate()) : 'Today, ${DateFormat('dd-MM-yyyy').format(DateTime.now())}'}'),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('- List of products: '),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ExportProductList(
                                          list: listDetailOrder,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Total Price: ${totalMoney.toInt().toString().toVND()}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                                  ? (deliveryReceipt
                                                              .idDeliveryReceipt ==
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
                                                                deliveryReceipt
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
                                Expanded(child: Container())
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
  }

  Widget _importOrderInfo() {
    var od = widget.order;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          title: Text(od.nameCustomer!),
          subtitle: Text(DateFormat('dd-MM-yyyy hh:mm:ss aa')
              .format(od.dateCreated!.toDate())),
          leading: const CircleAvatar(
            child: Icon(Icons.dashboard_customize),
          ),
        ));
  }
}
