import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../custom_search.dart';
import 'trouble_datagrid.dart';
import 'trouble_datasource.dart';

class TroubleList extends StatelessWidget {
  const TroubleList({
    Key? key,
  }) : super(key: key);

  void onChangeText(BuildContext context, String value) {
    context.read<TroubleBloc>().add(GetTroublesByFilter(textSearch: value));
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
              onChangeText: onChangeText,
            ),
          ),
          Expanded(
            flex: 7,
            child: BlocBuilder<TroubleBloc, TroubleState>(
                builder: (context, state) {
              if (state is TroubleLoaded) {
                TroubleDataSource troubleDataSource =
                    TroubleDataSource(troubles: state.myData, context: context);
                return state.myData.isEmpty? const Center(child: Text('No value')):TroubleDataGrid(
                  troubleDataSource: troubleDataSource,
                );
              }
              else{ return Container();}
            }),
          ),
        ],
      ),
    );
  }
}
