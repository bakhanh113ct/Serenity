import 'package:flutter/material.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/screen/all_order_tab.dart';
import 'package:serenity/screen/cancelled_order_tab.dart';
import 'package:serenity/screen/completed_order_tab.dart';
import 'package:serenity/screen/pending_order_tab.dart';

import '../routes/Routes.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      backgroundColor: CustomColor.customBackground,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order",
                            style: TextStyle(
                                color: CustomColor.second,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                                
                          ),
                          ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.cart);
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Icon(Icons.add)
                              ],
                            ),
                          )),
                        ],
                      )),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16),
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: SizedBox(
              //       height: 50,
              //       width: 120,
              //       child: ElevatedButton(
              //           onPressed: () {
              //             Navigator.pushNamed(context, Routes.cart);
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "Create",
              //                 style: TextStyle(fontSize: 18),
              //               ),
              //               Icon(Icons.add)
              //             ],
              //           )),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16,right: 16, bottom: 20),
                  child: Container(
                      // height: size.height * 0.7,
                      // height: 600,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 500,
                                color: Colors.white,
                                child: TabBar(
                                    controller: _tabController,
                                    labelColor: CustomColor.second,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorColor: CustomColor.second,
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    tabs: const [
                                      Tab(
                                        text: "All orders",
                                      ),
                                      Tab(
                                        text: "Completed",
                                      ),
                                      Tab(
                                        text: "Pending",
                                      ),
                                      Tab(
                                        text: "Cancelled",
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          Expanded(
                            // child: Container(
                            //   // width: double.maxFinite,
                            //   // height: double.infinity,
                              child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _tabController,
                                  children: const [
                                    AllOrderTab(),
                                    CompletedOrderTab(),
                                    PendingOrderTab(),
                                    CancelledOrderTab()
                                  ]),
                            ),
                          // )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialogCreateOrder() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              // height: 800,
              // width: 1200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: CustomColor.customBackground),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Create Order",
                          style: TextStyle(
                              color: CustomColor.second,
                              fontSize: 28,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: CustomColor.second,
                          size: 50,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(children: []),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(children: []),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
