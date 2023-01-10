import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/widget/input_dropdown.dart';
import 'package:serenity/widget/input_employee.dart';
import 'package:serenity/widget/input_import_voucher.dart';

class PaymentVoucher extends StatefulWidget {
  const PaymentVoucher({super.key});

  @override
  State<PaymentVoucher> createState() => _PaymentVoucherState();
}

class _PaymentVoucherState extends State<PaymentVoucher> {
  late TextEditingController dateController;

  late TextEditingController receiverNameController;
  late TextEditingController receiverAddressController;
  late TextEditingController totalController;
  late TextEditingController inWordsController;
  late TextEditingController noteController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  @override
  void initState() {
    dateController = TextEditingController();
    receiverNameController = TextEditingController();
    receiverAddressController = TextEditingController();
    totalController = TextEditingController();
    inWordsController = TextEditingController();
    noteController = TextEditingController();
    descriptionController = TextEditingController();
    selectedDate = DateTime.now();
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEBFDF2),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Import order list',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Color(0xFF226B3F),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                height: size.height * 0.8,
                width: size.width * 0.9,
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: InputImportVoucher(
                                    text: 'Date',
                                    controller: dateController,
                                    icon: Icons.calendar_month,
                                    onPress: () {
                                      _selectDate(context);
                                    },
                                    textInputType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: InputImportVoucher(
                                        text: 'Total amount',
                                        icon: Icons.abc,
                                        controller: totalController,
                                        onPress: () {},
                                        textInputType: TextInputType.text)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InputImportVoucher(
                                    text: 'Receiver',
                                    controller: receiverNameController,
                                    icon: Icons.abc,
                                    onPress: () {},
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: InputImportVoucher(
                                        text: 'In words',
                                        icon: Icons.abc,
                                        controller: inWordsController,
                                        onPress: () {},
                                        textInputType: TextInputType.text)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InputImportVoucher(
                                    text: 'Receiver Address',
                                    controller: receiverAddressController,
                                    icon: Icons.abc,
                                    onPress: () {},
                                    textInputType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: InputImportVoucher(
                                        text: 'Description',
                                        icon: Icons.abc,
                                        controller: descriptionController,
                                        onPress: () {},
                                        textInputType: TextInputType.text)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        )),
      ),
    );
  }
}
