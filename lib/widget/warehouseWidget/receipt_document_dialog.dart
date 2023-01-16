// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocReceiptDocument/receipt_document_bloc.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/model/product_import_order.dart';
import 'package:serenity/repository/import_order_repository.dart';
import 'package:serenity/widget/warehouseWidget/product_list.dart';
import '../../bloc/blocReceiptDocument/receipt_document_repository.dart';
import '../../bloc/blocUser/user_repository.dart';
import '../../model/User.dart';
import '../../model/receipt_document.dart';

enum SignaturePerson { staff }

class ReceiptDocumentEditDialog extends StatefulWidget {
  const ReceiptDocumentEditDialog({
    Key? key,
    required this.idReceiptDocument,
    required this.title,
    required this.isEdit,
  }) : super(key: key);
  final String idReceiptDocument;
  final String title;
  final bool isEdit;
  @override
  State<ReceiptDocumentEditDialog> createState() =>
      _ReceiptDocumentEditDialogState();
}

class _ReceiptDocumentEditDialogState extends State<ReceiptDocumentEditDialog> {
  var editReceiptDocument = ReceiptDocument(
      idReceiptDocument: '',
      idStaff: '',
      totalMoney: '',
      idImportOrder: '',
      dateCreated: Timestamp.now(),
      listProducts: <ProductImportOrder>[],
      nameSupplier: '',
      signStaff: '');
  var user = User();
  var receiptDocument = ReceiptDocument();
  var importOrder = ImportOrder();
  var listImportOrder = <ImportOrder>[];
  XFile? signStaff;
  final _form = GlobalKey<FormState>();
  var isLoading = true;

  // save the form
  void _saveForm(BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (widget.idReceiptDocument == '') {
      if (signStaff == null) {
        return;
      }
      var imageStaff =
          await ReceiptDocumentRepository().uploadSignReceiptDocument(signStaff);
      // add ReceiptDocument
      editReceiptDocument = editReceiptDocument.copyWith(
        idImportOrder: editReceiptDocument.idImportOrder,
        dateCreated: Timestamp.fromDate(DateTime.now()),
        totalMoney: editReceiptDocument.totalMoney,
        idStaff: user.idUser,
        signStaff: imageStaff,
        idReceiptDocument: editReceiptDocument.idReceiptDocument,
        nameSupplier: editReceiptDocument.nameSupplier,
        listProducts: editReceiptDocument.listProducts,
      );
      if (!mounted) return;
      context.read<ReceiptDocumentBloc>()
          .add(AddReceiptDocument(receiptDocument: editReceiptDocument));
      const snackBar = SnackBar(
        content: Text('Add Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String? imageStaff;
      if (signStaff != null) {
        imageStaff =
            await ReceiptDocumentRepository().uploadSignReceiptDocument(signStaff);
      }
      // update ReceiptDocument
      // editReceiptDocument = editReceiptDocument.copyWith(
      //   idTrouble: widget.idTrouble,
      //   idCustomer: customer.idCustomer,
      //   dateCreated: Timestamp.fromDate(DateTime.now()),
      //   dateSolved: '',
      //   totalMoney: totalMoney.toString(),
      //   isCompensate: compensation == 'compensate' ? true : false,
      //   status: 'Pending',
      //   idStaff: user.idUser,
      //   signCus: imageCus ?? ReceiptDocument.signCus,
      //   signStaff: imageStaff ?? ReceiptDocument.signStaff,
      //   idReceiptDocument: ReceiptDocument.idReceiptDocument,
      // );
      if (!mounted) return;
      // context
      //     .read<ReceiptDocumentBloc>()
      //     .add(UpdateReceiptDocument(ReceiptDocument: editReceiptDocument));
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
    if(widget.idReceiptDocument.isNotEmpty) {
      receiptDocument = await ReceiptDocumentRepository().getReceiptDocument(widget.idReceiptDocument);
      importOrder = await ImportOrderRepository().getIO(receiptDocument.idImportOrder!);
      user = await UserRepository().getUserByIdUser(receiptDocument.idStaff!);
    }
    else{
      user = await UserRepository().getUser();
    }
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
                                      'Import Order',
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
                            importOrder.idImportOrder == null ? Container() : Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, bottom: 20),
                              height: 500,
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
                                            '- Documents will confirm the import of goods into the warehouse from the company: ${importOrder.nameA}'),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '- Time confirmation: Today, ${DateFormat('dd-MM-yyyy').format(DateTime.now())}'),
                                      ),
                                      const Padding(
                                              padding:
                                                  EdgeInsets.all(8.0),
                                              child: Text(
                                                  '- List of products: '),
                                            ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ProductList( list: importOrder.listProduct!),
                                            ),
                                      Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  '- Total Price: ${importOrder.totalPrice!}'),
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
                                                  ? (receiptDocument
                                                              .idReceiptDocument ==
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
                                                                receiptDocument
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
    return DropdownSearch<ImportOrder>(
      enabled: widget.title == 'View Receipt Document' ? false : true,
      asyncItems: (filter) => getImportOrder(filter.toLowerCase()),
      compareFn: (i, s) {
        return i.idImportOrder!
                .toLowerCase()
                .compareTo(s.idImportOrder!.toLowerCase()) >
            0;
      },
      dropdownBuilder: _importOrderDropDownBuilder,
      popupProps: PopupPropsMultiSelection.dialog(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: _importOrderPopupItemBuilder,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: 'Choose Import Order',
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        ),
      ),
      onChanged: ((value) {
        setState(() {
          importOrder = value!;
        });
      }),
      onSaved: (value) async {
        editReceiptDocument = ReceiptDocument(
          idImportOrder: value!.idImportOrder,
          nameSupplier: value.nameA,
          idStaff: editReceiptDocument.idStaff,
          idReceiptDocument: editReceiptDocument.idReceiptDocument,
          dateCreated: editReceiptDocument.dateCreated,
          listProducts: value.listProduct,
          signStaff: editReceiptDocument.signStaff,
          totalMoney: value.totalPrice,
        );
      },
      validator: ((value) {
        if (value == null && editReceiptDocument.idImportOrder!.isEmpty) {
          return 'Please choose a import order';
        }
        return null;
      }),
    );
  }

  Future<List<ImportOrder>> getImportOrder(String text) async {
    List<ImportOrder> allImportOrder =
        await ImportOrderRepository().getListImportOrder();

    List<ReceiptDocument> allReceiptDocument = await ReceiptDocumentRepository().get();
    List<ImportOrder> list = List.from(allImportOrder);
    for (var rc in allReceiptDocument) { 
      for (var element in allImportOrder) {
        var i = element;
        if(element.idImportOrder == rc.idImportOrder){
          list.remove(i);
        }
       }
    }
    allImportOrder = list;
    
    if (text.isEmpty || text == '') {
      return allImportOrder;
    } else {
      allImportOrder.retainWhere((ip) {
        return (ip.idImportOrder!.toLowerCase().contains(text) ||
            ip.nameA!.toLowerCase().contains(text) ||
            ip.nameB!.toLowerCase().contains(text) ||
            ip.phoneA!.toLowerCase().contains(text) ||
            ip.phoneB!.toLowerCase().contains(text) ||
            ip.positionA!.toLowerCase().contains(text) ||
            ip.positionB!.toLowerCase().contains(text) ||
            ip.noAuthorizationA!.toLowerCase().contains(text) ||
            ip.noAuthorizationB!.toLowerCase().contains(text) ||
            ip.phoneA!.toLowerCase().contains(text));
      });
    }
    return allImportOrder;
  }

  Widget _importOrderDropDownBuilder(
      BuildContext context, ImportOrder? selectedItem) {
    if (selectedItem == null) {
      if (editReceiptDocument.idImportOrder!.isEmpty) {
        return const Text('No value selected');
      } else {
        final ip = listImportOrder.firstWhere(((element) =>
            element.idImportOrder == editReceiptDocument.idImportOrder));
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            title: Text(ip.nameA!),
            subtitle: Text(
                '${ip.totalPrice!}\n${DateFormat('dd-MM-yyyy hh:mm:ss aa').format(ip.dateCreated!.toDate())}'),
            leading: const CircleAvatar(
              child: Icon(Icons.document_scanner),
            ),
          ),
        );
      }
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          title: Text(selectedItem.nameA!),
          subtitle: Text(
              '${selectedItem.totalPrice!}\n${DateFormat('dd-MM-yyyy hh:mm:ss aa').format(selectedItem.dateCreated!.toDate())}'),
          leading: const CircleAvatar(
            child: Icon(Icons.document_scanner),
          ),
        ),
      );
    }
  }

  Widget _importOrderPopupItemBuilder(
      BuildContext context, ImportOrder item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Text(item.nameA!),
        subtitle: Text(
            '${item.totalPrice!}\n${DateFormat('dd-MM-yyyy hh:mm:ss aa').format(item.dateCreated!.toDate())}'),
        leading: const CircleAvatar(
          child: Icon(Icons.document_scanner),
        ),
      ),
    );
  }
}
