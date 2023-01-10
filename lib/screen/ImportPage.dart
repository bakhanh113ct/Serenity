import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/screen/create_import_order.dart';
import 'package:serenity/screen/payment_voucher.dart';

import '../bloc/importOrder/import_order_bloc.dart';
import '../common/color.dart';
import '../model/import_order.dart';
import '../widget/table_import_order.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

List<String> listTab = ['All Order', 'Completed', 'Continuing', 'Canceled'];

class _ImportPageState extends State<ImportPage> with TickerProviderStateMixin {
  int tabIndex = 0;
  List<ImportOrder> employees = <ImportOrder>[];

  // final PageController tabController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TabController tabController = TabController(length: 5, vsync: this);

    return Scaffold(
      backgroundColor: Color(0xFFEBFDF2),
      body: SingleChildScrollView(
        child: BlocBuilder<ImportOrderBloc, ImportOrderState>(
          builder: (context, state) {
            if (state is ImportOrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ImportOrderLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Import order list',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            color: Color(0xFF226B3F),
                            fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateImportOrder()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'New order',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.add,
                              size: 20,
                            )
                          ],
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 15)),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF226B3F))),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: size.height * 0.80,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 550,
                              color: Colors.white,
                              child: TabBar(
                                  controller: tabController,
                                  labelColor: CustomColor.second,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: CustomColor.second,
                                  labelStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  tabs: const [
                                    Tab(
                                      text: "All orders",
                                    ),
                                    Tab(
                                      text: "Pending",
                                    ),
                                    Tab(
                                      text: "Trouble",
                                    ),
                                    Tab(
                                      text: "Completed",
                                    ),
                                    Tab(
                                      text: "Canceled",
                                    )
                                  ]),
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 600,
                            child: TabBarView(
                                controller: tabController,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: TableImportOrder(
                                      tab: 'All',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: TableImportOrder(
                                      tab: 'Pending',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: TableImportOrder(
                                      tab: 'Trouble',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: TableImportOrder(
                                      tab: 'Completed',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: TableImportOrder(
                                      tab: 'Canceled',
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      )),
                ]),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}

// class TabButton extends StatelessWidget {
//   const TabButton({
//     Key? key,
//     required this.text,
//     required this.isChoose,
//     required this.onTap,
//   }) : super(key: key);
//   final String text;
//   final bool isChoose;
//   final Function onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             onTap();
//           },
//           child: Text(
//             text,
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 color: isChoose ? Color(0xFF226B3F) : Color(0xFFA09E9E),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           width: 120,
//           child: Divider(
//             thickness: isChoose ? 4 : 2,
//             height: isChoose ? 4 : 2,
//             color: isChoose ? Color(0xFF226B3F) : Color(0xFF226B3F),
//           ),
//         )
//       ],
//     );
//   }
// }
