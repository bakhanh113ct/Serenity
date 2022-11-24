import 'package:flutter/material.dart';
import 'package:serenity/widget/customer_header.dart';

import '../bloc/bloc_exports.dart';
import '../datasource/customer_datasource.dart';
import '../widget/customer_list.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);
  static const routeName = '/customer';
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  Map<String, double> columnWidths = {
    'id': 200,
    'name': 200,
    'address': 200,
    'email': 200,
    'phone': 200,
    'purchased': 200,
    'actions': 200,
    'imageUrl': 200,
    'dateOfBirth': 200,
  };
  // void addCustomer(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const Dialog(
  //         child: AddCustomerDialog(
  //           id: '',
  //         ),
  //       );
  //     },
  //   );
  // }
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerBloc>(context).add(const GetAllCustomers());
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        CustomerDataSource customerDataSource =
            CustomerDataSource(customers: state.allCustomers, context: context);
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const Expanded(
                flex:1,
                child: CustomerHeader(title:  'Customers')),
              Expanded(
                flex: 5,
                child: isLoading ? const CircularProgressIndicator() : CustomerList(
                    customerDataSource: customerDataSource,
                    columnWidths: columnWidths),
              ),
            ],
          ),
        );
      },
    );
  }
}
