import 'package:flutter/material.dart';

import '../../bloc/bloc_exports.dart';
import '../custom_search.dart';
import 'report_trouble_datagrid.dart';
import 'report_trouble_datasource.dart';

class ReportTroubleList extends StatefulWidget {
  const ReportTroubleList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportTroubleList> createState() => _ReportTroubleListState();
}

class _ReportTroubleListState extends State<ReportTroubleList> {
  void onSearch(BuildContext context, String value) {
    context
        .read<ReportTroubleBloc>()
        .add(GetReportTroublesByFilter(textSearch: value));
  }

  @override
  void initState() {
    super.initState();
    context.read<ReportTroubleBloc>().add(const GetReportTrouble());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: CustomSearch(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            flex: 7,
            child: BlocBuilder<ReportTroubleBloc, ReportTroubleState>(
                builder: (context, state) {
              if (state is ReportTroubleLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReportTroubleLoaded) {
                ReportTroubleDataSource reportTroubleDataSource =
                    ReportTroubleDataSource(
                        reportTroubles: state.myData,
                        customers: state.myCustomers,
                        context: context);
                return state.myData.isEmpty
                    ? const Center(child: Text('No value'))
                    : ReportTroubleDataGrid(
                        reportTroubleDataSource: reportTroubleDataSource,
                      );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
