import 'package:flutter/material.dart';
import 'package:serenity/bloc/blocTrouble/trouble_bloc.dart';
import '../bloc/bloc_exports.dart';
import '../common/color.dart';
import '../model/trouble.dart';
import '../widget/troubleWidget/trouble_datasource.dart';
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
    _tabController = TabController(length: 1, vsync: this);
   context.read<TroubleBloc>().add(const GetData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TroubleBloc, TroubleState>(
        builder: (context, state) {
          if (state is TroubleLoading) {
            return  const Center(child: CircularProgressIndicator());
          }
          if (state is TroubleLoaded) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  const Expanded(
                      flex: 1, child: TroubleHeader(title: 'Troubles')),
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
                                            text: "All Troubles",
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
                                    TroubleList()
                                  ]),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
    );
  }
}
