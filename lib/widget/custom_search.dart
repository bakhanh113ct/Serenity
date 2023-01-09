import 'package:flutter/material.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import 'customerWidget/customer_datasource.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key, required this.onChangeText});
  // final CustomerDataSource customerDataSource;
  final Function onChangeText;
  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        SizedBox(
          height: 40,
          
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                hintText: 'Search here...',
                suffixIcon: Icon(Icons.search),
                labelText: 'Search here',
               contentPadding: EdgeInsets.only(left: 15, top: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            onChanged: (value) {
              // context.read<CustomerBloc>().add(GetCustomersByFilter(textSearch: value));
              widget.onChangeText(context, value);
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
  
          ),
        ),
      ],
    );
  }
}
