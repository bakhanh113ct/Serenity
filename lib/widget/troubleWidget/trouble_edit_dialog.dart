// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocCustomer/customer_repository.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/model/Customer.dart';
import '../../bloc/blocTrouble/trouble_repository.dart';
import '../../model/trouble.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TroubleEditDialog extends StatefulWidget {
  const TroubleEditDialog({
    Key? key,
    required this.idTrouble,
    required this.title,
    required this.isEdit,
  }) : super(key: key);
  final String idTrouble;
  final String title;
  final bool isEdit;
  @override
  State<TroubleEditDialog> createState() => _TroubleEditDialogState();
}

class _TroubleEditDialogState extends State<TroubleEditDialog> {
  var initValues = {
    'nameCustomer': '',
    'description': '',
    'status': 'Received',
    'dateCreated': Timestamp.now(),
    'dateSolved': '',
    'idCustomer': '',
  };
  var editTrouble = Trouble(
      idTrouble: '',
      nameCustomer: '',
      description: '',
      idCustomer: '',
      dateCreated: Timestamp.now(),
      dateSolved: '',
      status: '');
  var listCustomers = <Customer>[];
  var customer = Customer();
  final _form = GlobalKey<FormState>();
  var isLoading = true;


  void _saveForm(BuildContext context) async {
    if (!mounted) return;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (editTrouble.idTrouble == '') {
      //add Trouble
      context.read<TroubleBloc>().add(AddTrouble(trouble: editTrouble));
      const snackBar = SnackBar(
        content: Text('Add Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      // update Trouble
      context.read<TroubleBloc>().add(UpdateTrouble(trouble: editTrouble));
      const snackBar = SnackBar(
        content: Text('Update Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (!mounted) return;
    if (widget.idTrouble == '') {
      setState(() {
        isLoading = false;
      });
      return;
    }
    listCustomers = await CustomerRepository().get();
    editTrouble = await TroubleRepository().getTrouble(widget.idTrouble);
    customer = await CustomerRepository().getCustomer(editTrouble.idCustomer!);
    initValues = {
      'nameCustomer': editTrouble.nameCustomer!,
      'description': editTrouble.description!,
      'status': editTrouble.status!,
      'dateCreated': editTrouble.dateCreated!,
      'idCustomer': editTrouble.idCustomer!,
      'dateSolved': editTrouble.dateSolved!,
    };
    if(!mounted) return;
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
                  width: MediaQuery.of(context).size.width * 0.3,
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
                            DropdownSearch<Customer>(
                              enabled: widget.title == 'View Trouble' ? false : true,
                              asyncItems: (filter) => getCustomer(filter),
                              compareFn: (i, s) {
                                return i.name!
                                        .toLowerCase()
                                        .compareTo(s.name!.toLowerCase()) >
                                    0;
                              },
                              dropdownBuilder: _customerDropDownBuilder,
                              popupProps: PopupPropsMultiSelection.dialog(
                                isFilterOnline: true,
                                showSelectedItems: true,
                                showSearchBox: true,
                                itemBuilder: _customerPopupItemBuilder,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: 'Choose Customer',
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                ),
                              ),
                              onChanged: ((value) => customer = value!),
                              onSaved: (value) async {                               
                                editTrouble = Trouble(
                                    idTrouble: editTrouble.idTrouble,
                                    nameCustomer: customer.name,
                                    description: editTrouble.description,
                                    status: editTrouble.status,
                                    dateCreated: editTrouble.dateCreated,
                                    dateSolved: editTrouble.dateSolved,
                                    idCustomer: customer.idCustomer,);
                              },
                              validator: ((value) {
                                if(value == null && editTrouble.idCustomer!.isEmpty){
                                  return 'Please choose a customer regarding trouble';
                                }
                                return null;
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            
                            DateTimeFormField(
                              dateFormat: DateFormat('dd/MM/yyyy hh:mm:ss a'),
                              initialDate:
                                  (initValues['dateCreated']! as Timestamp)
                                      .toDate(),
                              decoration: const InputDecoration(
                                  labelText: 'Date Created',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_month)),
                              mode: DateTimeFieldPickerMode.dateAndTime,
                              initialValue:
                                  (initValues['dateCreated']! as Timestamp)
                                      .toDate(),
                              onSaved: (value) {
                                editTrouble = Trouble(
                                    idTrouble: editTrouble.idTrouble,
                                    nameCustomer: editTrouble.nameCustomer,
                                    description: editTrouble.description,
                                    status: editTrouble.status,
                                    dateCreated: Timestamp.fromDate(value!),
                                    dateSolved: editTrouble.dateSolved,
                                    idCustomer: editTrouble.idCustomer);
                              },
                              use24hFormat: true,
                              enabled: widget.isEdit,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              initialValue: initValues['description'] as String,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(),
                              ),
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please describe something about trouble';
                                }
                                return null;
                              }),
                              textInputAction: TextInputAction.next,
                              readOnly: !widget.isEdit,
                              maxLines: 3,
                              onSaved: (value) {
                                editTrouble = Trouble(
                                    idTrouble: editTrouble.idTrouble,
                                    nameCustomer: editTrouble.nameCustomer,
                                    description: value!,
                                    status: editTrouble.status,
                                    dateCreated: editTrouble.dateCreated,
                                    dateSolved: editTrouble.dateSolved,
                                    idCustomer: editTrouble.idCustomer);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              initialValue: initValues['status'] as String,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              readOnly: true,
                              onSaved: (value) {
                                editTrouble = Trouble(
                                    idTrouble: editTrouble.idTrouble,
                                    nameCustomer: editTrouble.nameCustomer,
                                    description: editTrouble.description,
                                    status: value!,
                                    dateCreated: editTrouble.dateCreated,
                                    dateSolved: editTrouble.dateSolved,
                                    idCustomer: editTrouble.idCustomer);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              initialValue: (initValues['dateSolved'] as String).isEmpty ? 'No data' : initValues['dateSolved'] as String,
                              decoration: const InputDecoration(
                                labelText: 'Date Solved',
                                border: OutlineInputBorder(),
                              ),
                              textInputAction: TextInputAction.done,
                              readOnly: true,
                              onSaved: (value) {
                                editTrouble = Trouble(
                                    idTrouble: editTrouble.idTrouble,
                                    nameCustomer: editTrouble.nameCustomer,
                                    description: editTrouble.description,
                                    status: editTrouble.status,
                                    dateCreated: editTrouble.dateCreated,
                                    dateSolved: value,
                                    idCustomer: editTrouble.idCustomer);
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

  Future<List<Customer>> getCustomer(String text) async {
    List<Customer> allCustomers = await CustomerRepository().get();
    if (text.isEmpty || text == '') {
      return allCustomers;
    } else {
      allCustomers.retainWhere((cus) {
        return (cus.idCustomer!.contains(text) ||
            cus.name!.contains(text) ||
            cus.address!.contains(text) ||
            cus.phone!.contains(text) ||
            cus.dateOfBirth!.toString().contains(text) ||
            cus.email!.contains(text));
      });
    }
    return allCustomers;
  }

  Widget _customerPopupItemBuilder(
      BuildContext context, Customer item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Text(item.name!),
        subtitle: Text('${item.phone!}\n${item.email!}'),
        leading: CircleAvatar(backgroundImage: NetworkImage(item.image!)),
      ),
    );
  }

  Widget _customerDropDownBuilder(
      BuildContext context, Customer? selectedItem) {
    
    if (selectedItem == null) {
      if(editTrouble.idCustomer!.isEmpty) {
        return const Text('No value selected');
      }
      else{
        final customer = listCustomers.firstWhere((element) => element.idCustomer == editTrouble.idCustomer);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            title: Text(customer.name!),
            subtitle: Text('${customer.phone!}\n${customer.email!}'),
            leading: CircleAvatar(
                backgroundImage: NetworkImage(customer.image!)),
          ),
        );
      }
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          title: Text(selectedItem.name!),
          subtitle: Text('${selectedItem.phone!}\n${selectedItem.email!}'),
          leading:
              CircleAvatar(backgroundImage: NetworkImage(selectedItem.image!)),
        ),
      );
    }
  }
}
