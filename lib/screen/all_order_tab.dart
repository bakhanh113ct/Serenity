import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/dataSource/order_datasource.dart';
import 'package:serenity/widget/table_order.dart';

import '../bloc/blocOrder/order_bloc.dart';

class AllOrderTab extends StatefulWidget {
  const AllOrderTab({super.key});

  @override
  State<AllOrderTab> createState() => _AllOrderTabState();
}

class _AllOrderTabState extends State<AllOrderTab> {
  final _queryController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(LoadOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return Container();
        } else if (state is OrderLoaded) {
          final orders = OrderDataSource(orderData: state.listAllOrder!);
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        // obscureText: true,
                        controller: _queryController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            // enabledBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            hintText: 'Search for orderID, customer'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CustomColor.second),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<OrderBloc>(context).add(
                              SearchAllOrder(_queryController.text.trim()));
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: TableOrder(orders: orders)),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
