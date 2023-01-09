import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocTrouble/trouble_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../bloc/bloc_exports.dart';
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
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.columnName == 'more'
            ? Center(child: TroubleMoreButton(idTrouble: idTrouble))
            : Center(
                child: dataGridCell.columnName == 'status'
                    ? statusText(dataGridCell.value.toString())
                    : Text(dataGridCell.value.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis),
              ),
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
                      DateFormat('dd/MM/yyyy').format(e.dateCreated!.toDate())),
              const DataGridCell<String>(columnName: 'more', value: 'edit'),
            ]))
        .toList(growable: false);
  }

  Widget statusText(String status) {
    if (status == 'received') {
      return Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: Colors.yellow[200],
        ),
        child: Text(status, style: const TextStyle(fontSize: 15, color: Colors.red),),
      );
    }
    else if (status == 'solving') {
      return Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: Colors.yellow[200],
        ),
        child: Text(status),
      );
    }
    else  {
      return Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: Colors.yellow[200],
        ),
        child: Text(status),
      );
    }
  }
}
