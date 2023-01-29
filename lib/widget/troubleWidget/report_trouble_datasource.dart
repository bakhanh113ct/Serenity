import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/widget/troubleWidget/report_trouble_moreButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../model/Customer.dart';
import '../../model/report_trouble.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ReportTroubleDataSource extends DataGridSource {
  final BuildContext context;
  List<DataGridRow> _troubles = [];
  List<Customer> listCustomers = [];
  List<ReportTrouble> allReportTroubles = [];
  int newRowsPerPage = 1;
  ReportTroubleDataSource(
      {required List<ReportTrouble> reportTroubles,
      required List<Customer> customers,
      required this.context}) {
    if (reportTroubles.isEmpty || customers.isEmpty) return;
    allReportTroubles = reportTroubles;
    listCustomers = customers;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _troubles;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    String idReportTrouble = row
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
            dataGridCell.columnName == 'idReportTrouble')
        .value;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.centerLeft,
          child: getChildWidget(dataGridCell, idReportTrouble));
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _troubles = allReportTroubles.map<DataGridRow>((e) {
      var customer =
          listCustomers.firstWhere((cus) => cus.idCustomer == e.idCustomer);
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'idReportTrouble', value: e.idReportTrouble),
        DataGridCell<int>(columnName: 'no', value: i++),
        DataGridCell<String>(columnName: 'nameCustomer', value: customer.name),
        DataGridCell<String>(
            columnName: 'totalMoney', value: e.totalMoney.toVND(unit: 'đ')),
        DataGridCell<bool>(columnName: 'isCompensate', value: e.isCompensate),
        DataGridCell<String>(columnName: 'status', value: e.status),
        DataGridCell<String>(
            columnName: 'dateCreated',
            value: DateFormat('dd-MM-yyyy').format(e.dateCreated!.toDate())),
        const DataGridCell<String>(columnName: 'more', value: 'edit'),
      ]);
    }).toList(growable: false);
  }

  Widget statusText(String status) {
    if (status == 'Pending') {
      return Container(
        height: 45,
        width: 135,
        decoration: const BoxDecoration(
            color: Color(0xFFFEFFCB),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Center(
          child: Text(
            status,
            style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFEDB014),
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return Container(
        height: 45,
        width: 135,
        decoration: const BoxDecoration(
            color: Color(0xFFDCFBD7),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Center(
          child: Text(
            status,
            style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF5CB16F),
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  Widget getChildWidget(DataGridCell dataGridCell, String idReportTrouble) {
    if (dataGridCell.columnName == 'more') {
      return  ReportTroubleMoreButton(idReportTrouble: idReportTrouble);
    } else if (dataGridCell.columnName == 'isCompensate') {
      return  Checkbox(
              value: dataGridCell.value as bool,
              onChanged: ((value) {
                return;
              }));
    } else if (dataGridCell.columnName == 'status') {
      return statusText(dataGridCell.value.toString());
    } else {
      return Text(dataGridCell.value.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis);
    }
  }
}
