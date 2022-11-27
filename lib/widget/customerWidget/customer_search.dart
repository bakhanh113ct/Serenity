import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../../datasource/customer_datasource.dart';

class CustomerSearch extends StatefulWidget {
  const CustomerSearch({super.key, required this.customerDataSource});
  final CustomerDataSource customerDataSource;
  @override
  State<CustomerSearch> createState() => _CustomerSearchState();
}

class _CustomerSearchState extends State<CustomerSearch> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search here...',
                suffixIcon: Icon(Icons.search),
                labelText: 'Search here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            onChanged: (value) {
              context.read<CustomerBloc>().add(GetCustomersByFilter(textSearch: value));
              setState(() {
                widget.customerDataSource
                  .updateDataGriDataSource(RowsPerPage.row);
              });
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}
