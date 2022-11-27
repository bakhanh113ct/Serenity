import 'package:flutter/material.dart';
import 'package:serenity/widget/customerWidget/customer_header.dart';
import 'package:serenity/widget/customerWidget/customer_paging.dart';
import 'package:serenity/widget/customerWidget/customer_search.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../bloc/bloc_exports.dart';
import '../datasource/customer_datasource.dart';
import '../model/Customer.dart';
import '../widget/customerWidget/customer_list.dart';

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
  int switcherIndex1 = 0;
  bool isLoading = true;
  final List<Customer> allCustomers = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerBloc>(context).add(const GetAllCustomers());
    setState(() {
      isLoading = false;
      RowsPerPage.row = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              CustomerDataSource customerDataSource = CustomerDataSource(
                  customers: state.allCustomers, context: context);
              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    const Expanded(
                        flex: 1, child: CustomerHeader(title: 'Customers')),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: const EdgeInsets.all(50),
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SlideSwitcher(
                                       containerColor: Colors.transparent,
                                       containerBorder:
                                          Border.all(color: Colors.greenAccent, width: 2 ),
                                      slidersGradients: const [
                                        LinearGradient(
                                          colors: [
                                            Color.fromRGBO(52, 206, 67, 1),
                                            Color.fromRGBO(8, 166, 66, 1),
                                          ],
                                        ),
                                        
                                      ],
                                      
                                      indents: 2,
                                      onSelect: (index) =>
                                          setState(() => switcherIndex1 = index),
                                      containerHeight: 40,
                                      containerWight: 350,
                                      children:  [
                                        Text('Customers List', style: TextStyle(
                                          color: switcherIndex1 == 0 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),),
                                        Text(
                                          '...',
                                          style: TextStyle(
                                              color: switcherIndex1 == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (switcherIndex1 == 0) ...[
                              Expanded(
                                flex: 9,
                                child: CustomerListView(
                                      customerDataSource: customerDataSource,
                                      columnWidths: columnWidths)
                              )
                            ] else ...[
                              Expanded(
                                  flex: 9,
                                  child: Container()),
                              
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class CustomerListView extends StatelessWidget {
  const CustomerListView({
    Key? key,
    required this.customerDataSource,
    required this.columnWidths,
  }) : super(key: key);

  final CustomerDataSource customerDataSource;
  final Map<String, double> columnWidths;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: CustomerSearch(customerDataSource: customerDataSource),
          ),
          Expanded(
              flex: 7,
              child: customerDataSource.allCustomers.isEmpty
                  ? const Center(child: (Text('No value')))
                  : CustomerList(
                      customerDataSource: customerDataSource,
                      columnWidths: columnWidths)),
          Expanded(
              flex: 1,
              child: customerDataSource.allCustomers.isEmpty
                  ? Container()
                  : CustomerPaging(
                      customerDataSource: customerDataSource,
                    ))
        ],
      ),
    );
  }
}
