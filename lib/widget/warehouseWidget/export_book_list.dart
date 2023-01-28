import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import '../../bloc/blocExportBook/export_book_bloc.dart';
import '../custom_search.dart';
import 'export_book_datagrid.dart';
import 'export_book_datasource.dart';

class ExportBookList extends StatefulWidget {
  const ExportBookList({
    Key? key,
  }) : super(key: key);

  @override
  State<ExportBookList> createState() => _ExportBookListState();
}

class _ExportBookListState extends State<ExportBookList> {
  void onSearch(BuildContext context, String value) {
    context
        .read<ExportBookBloc>()
        .add(GetExportBooksByFilter(textSearch: value));
  }

  @override
  void initState() {
    super.initState();
    context.read<ExportBookBloc>().add(const GetAllExportBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            child: BlocBuilder<ExportBookBloc, ExportBookState>(
                builder: (context, state) {
              if (state is ExportBookLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExportBookLoaded) {
                ExportBookDataSource exportBookDataSource =
                    ExportBookDataSource(
                        exportProducts: state.myData, context: context);
                return state.myData.isEmpty
                    ? const Center(child: Text('No value'))
                    : ExportBookDataGrid(
                        exportBookDataSource: exportBookDataSource,
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
