import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:serenity/bloc/blocReportTrouble/report_trouble_repository.dart';
import 'package:serenity/bloc/blocTrouble/trouble_repository.dart';
import 'package:serenity/bloc/bloc_exports.dart';
import 'package:serenity/common/color.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:serenity/model/User.dart';

import '../../bloc/blocCustomer/customer_repository.dart';
import '../../bloc/blocUser/user_repository.dart';
import '../../model/report_trouble.dart';

import 'report_trouble_edit_dialog.dart';

enum ActionOptions { view, edit, close, payment, print }

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

  onPrint() async {
    reportTrouble = await ReportTroubleRepository()
        .getReportTrouble(widget.idReportTrouble);
    if(reportTrouble.status == 'Pending') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Center(
                  child: Text('Print',
                      style: Theme.of(context).textTheme.headline2)),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                      child: Text(
                    'Please payment before',
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
    }
    else{
      Print(reportTrouble);
    }
  }
  static void Print(ReportTrouble reportTrouble) async {
    final pdf = pw.Document();
    final ttf = await fontFromAssetBundle('assets/fonts/Poppins-Regular.ttf');
    var customer = await CustomerRepository().getCustomer(reportTrouble.idCustomer!);
    User staff = await UserRepository().getUserByIdUser(reportTrouble.idStaff!);
    var trouble = await TroubleRepository().getTrouble(reportTrouble.idTrouble!);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Column(children: [
                  pw.Text("SOCIALIST REPUBLIC OF VIETNAM",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Independence - Freedom - Happiness'),
                  pw.Text('****************************\n\n'),
                  pw.Text('REPORT TROUBLE DOCUMENT\n\n',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Align(alignment: pw.Alignment.topRight, 
                  child: pw.Text(
                        'Today, Date ${DateTime.now().day} Month ${DateTime.now().month} Year ${DateTime.now().year}'), ),
                ])),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('INFORMATION',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Id report trouble: ${reportTrouble.idReportTrouble}'),
                      pw.Text(
                          'The trouble happened at the time: ${DateFormat('dd-MM-yyyy hh:mm:ss aa').format(reportTrouble.dateCreated!.toDate())}'),
                      pw.Text('At place: Serenity Store'),
                       pw.Text('REPRESENTATION',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Party A ("Customer")',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name of customer: ${customer.name}'),
                      pw.Text('Number phone: ${customer.phone}'),
                      pw.Text('Email: ${customer.email}'),
                      pw.Text('Party B (The representative of store "Staff")',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Name of staff: ${staff.fullName}'),
                      pw.Text('Number phone: ${staff.phone}'),
                      pw.Text('Email: ${staff.email}'),
                      pw.Text('RECITALS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('1. Description of troubles.'),
                      pw.Text(
                          '\t\t${trouble.description}'),
                      pw.Text('2. Compensation'),
                      reportTrouble.isCompensate! ? pw.Text(
                          '\t\tThe store will receive from customer with total: ${reportTrouble.totalMoney.toVND()} '): pw.Text(
                          '\t\tCustomer will receive from the store with total: ${reportTrouble.totalMoney.toVND()} '),
                    ])),
                     pw.SizedBox(
                height: 200,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text('Customer'),
                          pw.Text(
                            '${customer.name}',
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text('Staff'),
                          pw.Text(
                            '${staff.fullName}',
                          ),
                        ],
                      )
                    ]))
          ]); // Center
        })); // Page

    final output = await getTemporaryDirectory();
    debugPrint(output.path);
    // final file = File('${output.path}/example.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
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
                  if (value == ActionOptions.print) {
                    onPrint();
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
                      const PopupMenuItem(
                        value: ActionOptions.print,
                        child: ListTile(
                          trailing: Icon(
                            Icons.print,
                            color: Colors.black,
                          ),
                          title: Text('Print'),
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
