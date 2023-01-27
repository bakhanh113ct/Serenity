import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import '../../bloc/blocImportBook/import_book_bloc.dart';
import '../custom_search.dart';
import 'import_book_datagrid.dart';
import 'import_book_datasource.dart';
import 'receipt_document_datagrid.dart';
import 'receipt_document_datasource.dart';

class ImportBookList extends StatefulWidget {
  const ImportBookList({
    Key? key,
  }) : super(key: key);

  @override
  State<ImportBookList> createState() => _ImportBookListState();
}

class _ImportBookListState extends State<ImportBookList> {
  void onSearch(BuildContext context, String value) {
    context
        .read<ImportBookBloc>()
        .add(GetImportBooksByFilter(textSearch: value));
  }

  @override
  void initState() {
    super.initState();
    context.read<ImportBookBloc>().add(const GetAllImportBooks());
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
            child: BlocBuilder<ImportBookBloc, ImportBookState>(
                builder: (context, state) {
              if (state is ImportBookLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ImportBookLoaded) {
                ImportBookDataSource importBookDataSource =
                    ImportBookDataSource(
                        importBookData: state.myData,
                        context: context);
                return state.myData.isEmpty
                    ? const Center(child: Text('No value'))
                    : ImportBookDataGrid(
                        importBookDataSource: importBookDataSource,
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
