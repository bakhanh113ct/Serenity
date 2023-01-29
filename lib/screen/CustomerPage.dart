import 'package:flutter/material.dart';
import 'package:serenity/widget/customerWidget/customer_header.dart';

import '../bloc/blocCustomer/customer_event.dart';
import '../bloc/blocCustomer/customer_state.dart';
import '../bloc/bloc_exports.dart';
import '../common/color.dart';
import '../model/customer.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Expanded(flex: 1, child: CustomerHeader(title: 'Customers')),
          Expanded(
            flex: 6,
            child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
