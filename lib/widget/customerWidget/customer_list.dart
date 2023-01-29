import 'package:flutter/material.dart';
import 'package:serenity/widget/customerWidget/customer_datagrid.dart';

import '../../bloc/blocCustomer/customer_event.dart';
import '../../bloc/blocCustomer/customer_state.dart';
import '../../bloc/bloc_exports.dart';
import 'customer_datasource.dart';
import '../custom_search.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({
    Key? key,
  }) : super(key: key);

  void onSearch(BuildContext context, String value){
    context.read<CustomerBloc>().add(GetCustomersByFilter(textSearch: value));
  }
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: CustomSearch(onSearch: onSearch,),
          ),
          Expanded(
              flex: 7,
              child: BlocBuilder<CustomerBloc, CustomerState>(
                builder: (context, state) {
              if (state is CustomerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }   
              else if (state is CustomerLoaded) {
                CustomerDataSource customerDataSource =
                    CustomerDataSource(customers: state.myData, context: context);
                return state.myData.isEmpty? const Center(child: Text('No value')):CustomerDataGrid(
                  customerDataSource: customerDataSource,
                );
              }
              else{ return Container();}
            })),
        ],
      ),
    );
  }
}
