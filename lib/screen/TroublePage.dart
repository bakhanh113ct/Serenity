import 'package:flutter/material.dart';
import 'package:serenity/widget/troubleWidget/report_trouble_list.dart';
import '../common/color.dart';
import '../widget/troubleWidget/trouble_header.dart';
import '../widget/troubleWidget/trouble_list.dart';

class TroublePage extends StatefulWidget {
  const TroublePage({Key? key}) : super(key: key);
  static const routeName = '/Trouble';
  @override
  State<TroublePage> createState() => _TroublePageState();
}

class _TroublePageState extends State<TroublePage>
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
          const Expanded(flex: 1, child: TroubleHeader(title: 'Troubles')),
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
                            width: 400,
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
                                    text: "All Troubles",
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
                          children: const [
                            TroubleList(),
                            ReportTroubleList(),
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
