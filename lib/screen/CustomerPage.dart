import 'package:flutter/material.dart';
import 'package:serenity/widget/customerWidget/customer_header.dart';
import 'package:serenity/widget/custom_search.dart';

import '../bloc/blocCustomer/customer_event.dart';
import '../bloc/blocCustomer/customer_state.dart';
import '../bloc/bloc_exports.dart';
import '../common/color.dart';
import '../widget/customerWidget/customer_datasource.dart';
import '../model/Customer.dart';
import '../widget/customerWidget/customer_datagrid.dart';
import '../widget/customerWidget/customer_list.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);
  static const routeName = '/customer';
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int switcherIndex1 = 0;
  bool isLoading = true;
  final List<Customer> allCustomers = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    BlocProvider.of<CustomerBloc>(context).add(const GetAllCustomers());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                                 
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        
                                        width: 200,
                                        padding: const EdgeInsets.all(20),
                                        child: TabBar(
                                            controller: _tabController,
                                            labelColor: CustomColor.second,
                                            unselectedLabelColor: Colors.grey,
                                            indicatorColor: CustomColor.second,
                                            labelStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                            tabs: const [
                                              Tab(
                                                text: "All Customers",
                                              ),
                                              
                                            ]),
                                      ),
                                    ],
                                  ),
                              ),
                              Expanded(
                                flex: 8,
                                child: TabBarView(
                                    controller: _tabController,
                                    children: const [
                                      CustomerList(),
                                    ]),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              );
  }
}

