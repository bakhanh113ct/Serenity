import 'package:flutter/material.dart';
import '../common/color.dart';
import '../widget/WarehouseWidget/Warehouse_header.dart';

class WarehousePage extends StatefulWidget {
  const WarehousePage({Key? key}) : super(key: key);
  static const routeName = '/Warehouse';
  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Expanded(flex: 1, child: WarehouseHeader(title: 'Warehouse')),
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
                      offset: const Offset(0, 1), // changes position of shadow
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
                            width: 600,
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
                                    text: "Product Receipt Document",
                                  ),
                                  Tab(
                                    text: "Report List",
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
                          children:  [
                            Container(),
                            Container(),
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
