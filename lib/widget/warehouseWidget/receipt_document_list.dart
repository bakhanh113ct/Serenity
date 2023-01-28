import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../../bloc/blocReceiptDocument/receipt_document_bloc.dart';
import '../custom_search.dart';
import 'receipt_document_datagrid.dart';
import 'receipt_document_datasource.dart';


class ReceiptDocumentList extends StatefulWidget {
  const ReceiptDocumentList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiptDocumentList> createState() => _ReceiptDocumentListState();
}

class _ReceiptDocumentListState extends State<ReceiptDocumentList> {
  void onSearch(BuildContext context, String value) {
    context.read<ReceiptDocumentBloc>().add(GetReceiptDocumentsByFilter(textSearch: value));
  }

  @override
  void initState() {
    super.initState();
    context.read<ReceiptDocumentBloc>().add(const GetAllReceiptDocuments());
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
            child: BlocBuilder<ReceiptDocumentBloc, ReceiptDocumentState>(
                builder: (context, state) {
              if (state is ReceiptDocumentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReceiptDocumentLoaded) {
                ReceiptDocumentDataSource receiptDocumentDataSource =
                    ReceiptDocumentDataSource(receiptDocuments: state.myReceiptDocument, context: context);
                return state.myReceiptDocument.isEmpty
                    ? const Center(child: Text('No value'))
                    : ReceiptDocumentDataGrid(
                        receiptDocumentDataSource: receiptDocumentDataSource,
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
