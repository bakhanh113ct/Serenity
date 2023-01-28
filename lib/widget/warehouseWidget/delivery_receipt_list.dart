import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../../bloc/blocDeliveryReceipt/delivery_receipt_bloc.dart';
import '../custom_search.dart';
import 'delivery_receipt_datagrid.dart';
import 'delivery_receipt_datasoure.dart';

class DeliveryReceiptList extends StatefulWidget {
  const DeliveryReceiptList({
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryReceiptList> createState() => _DeliveryReceiptListState();
}

class _DeliveryReceiptListState extends State<DeliveryReceiptList> {
  void onSearch(BuildContext context, String value) {
    context
        .read<DeliveryReceiptBloc>()
        .add(GetDeliveryReceiptsByFilter(textSearch: value));
  }

  @override
  void initState() {
    super.initState();
    context.read<DeliveryReceiptBloc>().add(const GetAllDeliveryReceipts());
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
            child: BlocBuilder<DeliveryReceiptBloc, DeliveryReceiptState>(
                builder: (context, state) {
              if (state is DeliveryReceiptLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DeliveryReceiptLoaded) {
                DeliveryReceiptDataSource deliveryReceiptDataSource =
                    DeliveryReceiptDataSource(
                        deliveryReceipts: state.myData,
                        context: context);
                return state.myData.isEmpty
                    ? const Center(child: Text('No value'))
                    : DeliveryReceiptDataGrid(
                        deliveryReceiptDataSource: deliveryReceiptDataSource,
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
