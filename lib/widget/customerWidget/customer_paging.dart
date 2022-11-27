// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:serenity/datasource/customer_datasource.dart';

class CustomerPaging extends StatefulWidget {
  const CustomerPaging({
    Key? key,
    required this.customerDataSource,
  }) : super(key: key);
  final CustomerDataSource customerDataSource;

  @override
  State<CustomerPaging> createState() => _CustomerPagingState();
}

class _CustomerPagingState extends State<CustomerPaging> {
  int newRowsPerPage = 1;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
      newRowsPerPage = RowsPerPage.row;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator() : Align(
                  alignment: Alignment.centerRight,
                  child: SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                      itemBorderWidth: 2,
                      selectedItemColor: Colors.green[400],
                      itemBorderColor: Colors.grey.shade400,
                      itemBorderRadius: BorderRadius.circular(10),
                    ),
                    child: SfDataPager(
                      pageCount:
                          ((widget.customerDataSource.allCustomers.length /
                                      newRowsPerPage)
                                  .ceil())
                              .toDouble(),
                      availableRowsPerPage: const [1, 2, 3],
                      onRowsPerPageChanged: (int? rowsPerPage) {
                        if (newRowsPerPage == rowsPerPage) {
                          return;
                        }
                        setState(() {
                          newRowsPerPage = rowsPerPage!;
                          RowsPerPage.row = newRowsPerPage;
                          widget.customerDataSource.updateDataGriDataSource(rowsPerPage);
                        });
                      },
                      visibleItemsCount: 2,
                      itemWidth: 70,
                      navigationItemWidth: 70,
                      delegate: widget.customerDataSource,
                    ),
                  ));
  }
}
