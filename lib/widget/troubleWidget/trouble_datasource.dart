import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../model/trouble.dart';
import 'trouble_moreButton.dart';

class TroubleDataSource extends DataGridSource {
  final BuildContext context;
  List<DataGridRow> _troubles = [];
  List<Trouble> allTroubles = [];
  int newRowsPerPage = 1;
  TroubleDataSource({required List<Trouble> troubles, required this.context}) {
    if (troubles.isEmpty) return;
    allTroubles = troubles;
    buildDataGridRows();
  }

  @override
  List<DataGridRow> get rows => _troubles;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    String idTrouble = row
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
            dataGridCell.columnName == 'idTrouble')
        .value;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: dataGridCell.columnName == 'more'
            ? TroubleMoreButton(idTrouble: idTrouble)
            :  dataGridCell.columnName == 'status'
                    ? statusText(dataGridCell.value.toString())
                    : Text(dataGridCell.value.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }

  void buildDataGridRows() {
    int i = 1;
    _troubles = allTroubles
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'idTrouble', value: e.idTrouble),
              DataGridCell<int>(columnName: 'no', value: i++),
              DataGridCell<String>(columnName: 'nameCustomer', value: e.nameCustomer),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(
                  columnName: 'dateCreated',
                  value:
                      DateFormat('dd-MM-yyyy').format(e.dateCreated!.toDate())),
              const DataGridCell<String>(columnName: 'more', value: 'edit'),
            ]))
        .toList(growable: false);
  }

  Widget statusText(String status) {
    if (status == 'Received') {
      return Container(
        decoration: const BoxDecoration(
            color: Color(0xFFFEFFCB),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          status,
          style: const TextStyle(
              fontSize: 20,
              color: Color(0xFFEDB014),
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
       return Container(
        decoration: const BoxDecoration(
            color: Color(0xFFDCFBD7),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          status,
          style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF5CB16F),
              fontWeight: FontWeight.w500),
        ),
      );
    }
  }
}
