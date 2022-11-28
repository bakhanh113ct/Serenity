import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/screen/invoice.dart';
import 'package:serenity/widget/table_employee.dart';

import '../bloc/employee/employee_bloc.dart';
import '../bloc/importOrder/import_order_bloc.dart';
import '../model/import_order.dart';
import '../widget/modal_add_employee.dart';
import '../widget/table_content.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  int tabIndex = 0;
  List<ImportOrder> employees = <ImportOrder>[];

  final PageController tabController = PageController();
  @override
  void initState() {
    super.initState();
  }

  List<String> listTab = ['All Employee', 'Active', 'Continuing', 'Canceled'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEBFDF2),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
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
                        builder: (BuildContext context) => AlertDialog(
                          // title: const Text('AlertDialog Title'),
                          content: ModalAddEmployee(),
                          // actions: <Widget>[
                          //   // TextButton(
                          //   //   onPressed: () => Navigator.pop(context, 'Cancel'),
                          //   //   child: const Text('Cancel'),
                          //   // ),
                          //   ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.pop(context, 'Cancel');
                          //     },
                          //     child: Text(
                          //       'Cancle ',
                          //       style: TextStyle(fontSize: 20),
                          //     ),
                          //     style: ButtonStyle(
                          //         maximumSize:
                          //             MaterialStateProperty.all(Size(110, 60)),
                          //         padding: MaterialStateProperty.all(
                          //             EdgeInsets.symmetric(
                          //                 vertical: 12, horizontal: 15)),
                          //         backgroundColor: MaterialStateProperty.all(
                          //             Color(0xFF226B3F))),
                          //   ),
                          //   ElevatedButton(
                          //     onPressed: () {
                          //       // Navigator.pop(context, 'Cancel');
                          //     },
                          //     child: Text(
                          //       'Save ',
                          //       style: TextStyle(fontSize: 20),
                          //     ),
                          //     style: ButtonStyle(
                          //         maximumSize:
                          //             MaterialStateProperty.all(Size(110, 60)),
                          //         padding: MaterialStateProperty.all(
                          //             EdgeInsets.symmetric(
                          //                 vertical: 12, horizontal: 15)),
                          //         backgroundColor: MaterialStateProperty.all(
                          //             Color(0xFF226B3F))),
                          //   ),
                          // ],
                        ),
                      ),
                      child: Row(
                        children: [
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
                  color: Colors.white,
                  height: 700,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(children: [
                    Container(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: ((context, index) => TabButton(
                                isChoose: tabIndex == index,
                                text: listTab[index].toString(),
                                onTap: () {
                                  setState(() {
                                    tabIndex = index;
                                  });
                                  tabController.animateToPage(index,
                                      duration: Duration(microseconds: 1000),
                                      curve: Curves.easeInSine);
                                },
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // obscureText: true,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: 'Search for orderID, customer'),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Table---------------------------------------------------------------------------------
                    Container(
                      height: 500,
                      child: PageView.builder(
                          controller: tabController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: ((context, index) =>
                              TableEmployee(employees: state.listEmployee))),
                    ),
                    // TableContent(),
                  ]),
                )
              ]),
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.text,
    required this.isChoose,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final bool isChoose;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: isChoose ? Color(0xFF226B3F) : Color(0xFFA09E9E),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 120,
          child: Divider(
            thickness: isChoose ? 4 : 2,
            height: isChoose ? 4 : 2,
            color: isChoose ? Color(0xFF226B3F) : Color(0xFF226B3F),
          ),
        )
      ],
    );
  }
}
