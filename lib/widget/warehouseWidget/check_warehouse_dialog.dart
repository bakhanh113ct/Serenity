// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:core';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';
import 'package:serenity/bloc/blocOrder/order_repository.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/detailOrder.dart';
import 'package:serenity/model/order.dart';
import 'package:serenity/model/product.dart';
import 'package:serenity/repository/detail_order_repository.dart';
import 'package:serenity/widget/warehouseWidget/delivery_receipt_dialog.dart';

enum SignaturePerson { staff }

class CheckWarehouseDialog extends StatefulWidget {
  const CheckWarehouseDialog({
    Key? key,
  }) : super(key: key);
  @override
  State<CheckWarehouseDialog> createState() => _CheckWarehouseDialogState();
}

class _CheckWarehouseDialogState extends State<CheckWarehouseDialog> {
  bool isLoading = true;
  bool isCheck = true;
  var myOrder = MyOrder();
  var listDetailOrder = <DetailOrder>[];
  @override
  void initState() {
    super.initState();
  }

  onContinue() async {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (context) {
          return DeliveryReceiptEditDialog(
            idDeliveryReceipt: '',
            isEdit: true,
            order: myOrder,
            title: 'Make delivery receipt',
          );
        });
  }

  @override
  void didChangeDependencies() async {
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
              (myOrder.idOrder != null && isCheck)
                  ? Row(
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
                                onContinue();
                              },
                              child: const Text('Continue')),
                        )
                      ],
                    )
                  : Center(
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Check Warehouse',
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
                                      'Choose Order',
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
                                      title: _chooseOrderInfo(),
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
                            myOrder.idOrder == null
                                ? Container()
                                : Container(
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
                                          offset: const Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _checkProduct(),
                                            isCheck
                                                ? ListTile(
                                                    leading: Icon(
                                                      Icons
                                                          .library_add_check_sharp,
                                                      color: CustomColor.second,
                                                    ),
                                                    title: const Text(
                                                      'Check completely, continue to make export document',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                : const ListTile(
                                                    leading: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                    title: Text(
                                                      'Please import enough goods before selling',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          ]),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
  }

  Widget _checkProduct() {
    return Column(
      children: listDetailOrder.map((e) {
        return FutureBuilder(
            future: getProduct(e.idProduct!, e),
            builder: (BuildContext context, AsyncSnapshot<Product> pro) {
              if (!pro.hasData) {
                return const Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()));
              } else if (pro.hasData) {
                bool stock = pro.data!.idProduct == null
                    ? false
                    : int.parse(pro.data!.amount!) >= int.parse(e.amount!);
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ListTile(
                    trailing: FittedBox(
                      child: Row(children: [
                        Column(
                          children: [
                            const Text('Stocking'),
                            SizedBox(
                              child: Checkbox(
                                  value: stock, onChanged: ((value) {})),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text('Out of stock'),
                            SizedBox(
                              child: Checkbox(
                                  value: !stock, onChanged: ((value) {})),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    title: Text('${e.name}'),
                    subtitle: Text(
                        'Amount: ${e.amount!}x \nStock: ${stock ? pro.data!.amount : (pro.data!.idProduct == null ? 0 : e.amount)}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pro.data!.image!),
                    ),
                  ),
                );
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: FittedBox(
                    child: ListTile(
                      trailing: Row(children: [
                        Column(
                          children: [
                            const Text('Stocking'),
                            SizedBox(
                              child: Checkbox(
                                  value: false, onChanged: ((value) {})),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text('Out of stock'),
                            SizedBox(
                              child: Checkbox(
                                  value: true, onChanged: ((value) {})),
                            ),
                          ],
                        ),
                      ]),
                      title: Text('${e.name}'),
                      subtitle: Text('Amount: ${e.amount!}x'),
                    ),
                  ),
                );
              }
            });
      }).toList(),
    );
  }

  Future<Product> getProduct(String idProduct, DetailOrder dt) async {
    var pro = await ImportBookRepository().getProductImportBook(idProduct);
    if (int.parse(pro.amount!) < int.parse(dt.amount!)) {
      setState(() {
        isCheck = false;
      });
    }
    return pro;
  }

  Widget _chooseOrderInfo() {
    return DropdownSearch<MyOrder>(
      asyncItems: (filter) => getMyOrder(filter.toLowerCase()),
      compareFn: (i, s) {
        if (i.idOrder == null || s.idOrder == null) return false;
        return i.idOrder!.toLowerCase().compareTo(s.idOrder!.toLowerCase()) > 0;
      },
      dropdownBuilder: _myOrderDropDownBuilder,
      popupProps: PopupPropsMultiSelection.dialog(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: _myOrderPopupItemBuilder,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: 'Choose Import Order',
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        ),
      ),
      onChanged: ((value) async {
        if (value!.idOrder == null) return;
        listDetailOrder =
            await DetailOrderRepository().getDetailOrder(value.idOrder!);
        setState(() {
          myOrder = value;
        });
      }),
      validator: ((value) {
        if (value == null) {
          return 'Please choose a import order';
        }
        return null;
      }),
    );
  }

  Future<List<MyOrder>> getMyOrder(String text) async {
    List<MyOrder> allOrder = (await OrderRepository().getOrder() as List<MyOrder>)
            .where((element) => element.status == 'Pending' && element.idOrder != null)
            .toList();

    if (text.isEmpty || text == '') {
      return allOrder;
    } else {
      allOrder.retainWhere((ip) {
        return (ip.idCustomer!.toLowerCase().contains(text) ||
            ip.idOrder!.toLowerCase().contains(text) ||
            ip.idUser!.toLowerCase().contains(text) ||
            ip.nameCustomer!.toLowerCase().contains(text) ||
            ip.price!.toLowerCase().contains(text));
      });
    }
    return allOrder;
  }

  Widget _myOrderDropDownBuilder(BuildContext context, MyOrder? selectedItem) {
    if (selectedItem == null) {
      return const Text('No value selected');
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          title: Text(selectedItem.nameCustomer!),
          subtitle: Text(DateFormat('dd-MM-yyyy hh:mm:ss aa')
              .format(selectedItem.dateCreated!.toDate())),
          leading: const CircleAvatar(
            child: Icon(Icons.dashboard_customize),
          ),
        ),
      );
    }
  }

  Widget _myOrderPopupItemBuilder(
      BuildContext context, MyOrder item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Text(item.nameCustomer!),
        subtitle: Text(DateFormat('dd-MM-yyyy hh:mm:ss aa')
            .format(item.dateCreated!.toDate())),
        leading: const CircleAvatar(
          child: Icon(Icons.document_scanner),
        ),
      ),
    );
  }
}
