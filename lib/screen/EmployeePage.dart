import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/widget/table_employee.dart';

import '../bloc/employee/employee_bloc.dart';
import '../common/color.dart';
import '../model/import_order.dart';
import '../widget/modal_add_employee.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage>
    with TickerProviderStateMixin {
  int tabIndex = 0;
  List<ImportOrder> employees = <ImportOrder>[];

  // final PageController tabController = PageController();
  @override
  void initState() {
    super.initState();
  }

  List<String> listTab = ['All Employee', 'Active', 'Continuing', 'Canceled'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFEBFDF2),
      body: SingleChildScrollView(
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Employee',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            color: Color(0xFF226B3F),
                            fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () => showDialog<String>(
                          // barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => const AlertDialog(
                            // title: const Text('AlertDialog Title'),
                            content: ModalAddEmployee(),
                          ),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 15)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF226B3F))),
                        child: Row(
                          children: const [
                            Text(
                              'New',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.add,
                              size: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),

                  // Table
                  Container(
                      height: size.height * 0.8,
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
                                      text: "All",
                                    ),
                                    Tab(
                                      text: "Active",
                                    ),
                                    Tab(
                                      text: "Inactive",
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 600,
                            child: TabBarView(
                                controller: tabController,
                                children: const [
                                  TableEmployee(state: 'all'),
                                  TableEmployee(state: 'active'),
                                  TableEmployee(state: 'inactive'),
                                  // TableEmployee(),
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
