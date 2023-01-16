import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:serenity/bloc/blocReportTrouble/report_trouble_repository.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/common/color.dart';

import '../../model/report_trouble.dart';

import 'report_trouble_edit_dialog.dart';

enum ActionOptions { view, edit, close, payment, already_payment }

class ReportTroubleMoreButton extends StatefulWidget {
  const ReportTroubleMoreButton({Key? key, required this.idReportTrouble})
      : super(key: key);
  final String idReportTrouble;
  @override
  State<ReportTroubleMoreButton> createState() =>
      _ReportTroubleMoreButtonState();
}

class _ReportTroubleMoreButtonState extends State<ReportTroubleMoreButton> {
  ReportTrouble reportTrouble = ReportTrouble();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (!mounted) return;

    reportTrouble = await ReportTroubleRepository()
        .getReportTrouble(widget.idReportTrouble);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  onView() async {
    showDialog(
      context: context,
      builder: (context) {
        return ReportTroubleEditDialog(
          idReportTrouble: widget.idReportTrouble,
          idTrouble: reportTrouble.idTrouble!,
          title: 'View Report Trouble',
          isEdit: false,
        );
      },
    );
  }

  onEdit()  async {
    reportTrouble = await ReportTroubleRepository()
        .getReportTrouble(widget.idReportTrouble);
    if (reportTrouble.status == 'Paymented') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title:  Center(child: Text('Edit', style:  Theme.of(context).textTheme.headline2,)),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                      child: Text(
                    'This report can\'t edit',
                    style: TextStyle(fontSize: 20),
                  ))),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Center(
                  child: SizedBox(
                    width: 200,
                    child: IconsOutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle:
                          TextStyle(color: CustomColor.second, fontSize: 15),
                      iconColor: Colors.grey,
                    ),
                  ),
                ),
              ]);
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return ReportTroubleEditDialog(
          idReportTrouble: widget.idReportTrouble,
          idTrouble: reportTrouble.idTrouble!,
          title: 'Edit Report Trouble',
          isEdit: true,
        );
      },
    );
  }

  onPayment() async {
    reportTrouble = await ReportTroubleRepository()
        .getReportTrouble(widget.idReportTrouble);
    if(reportTrouble.status == 'Paymented'){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title:  Center(child: Text('Payment',
                      style: Theme.of(context).textTheme.headline2)),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                      child: Text(
                    'This report has been paymented before',
                    style: TextStyle(fontSize: 20),
                  ))),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                 Center(
                   child: SizedBox(
                    width: 200,
                     child: IconsOutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: TextStyle(color: CustomColor.second, fontSize: 15),
                      iconColor: Colors.grey,
                ),
                   ),
                 ),
              ]);
        },
      );
      return;
    }
    String msg = '';
    if (reportTrouble.isCompensate!) {
      msg =
          'Are you sure ? You will receive from customer with total: ${reportTrouble.totalMoney.toVND(unit: 'đ')} ';
    } else {
      msg =
          'Are you sure ? Customer will receive from you with total: ${reportTrouble.totalMoney.toVND(unit: 'đ')} ';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          
            title: const Center(child: Text('Payment')),
            content: SizedBox(
               width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(child: Text(msg , style: const TextStyle(fontSize: 20),))),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconsOutlineButton(
                    onPressed: () { 
                      Navigator.of(context).pop();
                    },
                    text: 'Cancel',
                    iconData: Icons.cancel_outlined,
                    textStyle:  TextStyle(color: CustomColor.second , fontSize: 15),
                    iconColor: Colors.grey,
                  ),
                  IconsButton(
                    onPressed: () {
                      
                      Navigator.of(context).pop();
                      context.read<ReportTroubleBloc>().add(UpdateReportTrouble(
                              reportTrouble: reportTrouble.copyWith(
                            status: 'Paymented',
                            dateSolved: DateFormat('dd-MM-yyyy hh:mm:ss aa')
                                .format(DateTime.now()),
                      )));
                      const snackBar = SnackBar(
                        content: Text('Payment Successfully'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    text: 'Payment',
                    iconData: Icons.payment,
                    color: CustomColor.second,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                    iconColor: Colors.white,
                  ),
                ],
              )
            ]);
      },
    );
  }

  onAlreadyPayment() {}

  onClose() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Container(
            alignment: Alignment.center,
            child: PopupMenuButton<ActionOptions>(
                onSelected: (ActionOptions value) {
                  if (value == ActionOptions.view) {
                    onView();
                    return;
                  }
                  if (value == ActionOptions.edit) {
                    onEdit();
                    return;
                  }
                  if (value == ActionOptions.payment) {
                    onPayment();
                    return;
                  }
                  if (value == ActionOptions.already_payment) {
                    onAlreadyPayment();
                    return;
                  }
                  if (value == ActionOptions.close) {
                    onClose();
                    return;
                  }
                },
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: ActionOptions.view,
                        child: ListTile(
                          trailing:
                              Icon(Icons.view_comfortable, color: Colors.black),
                          title: Text('View'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: ActionOptions.edit,
                        child: ListTile(
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          title: Text('Edit'),
                        ),
                      ),
                      const PopupMenuItem(
                        value: ActionOptions.payment,
                        child: ListTile(
                          trailing: Icon(
                            Icons.payment,
                            color: Colors.black,
                          ),
                          title: Text('Payment    '),
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: ActionOptions.close,
                        child: ListTile(
                          trailing:
                              Icon(Icons.close_rounded, color: Colors.black),
                          title: Text('Close'),
                        ),
                      ),
                    ]),
          );
  }
}
