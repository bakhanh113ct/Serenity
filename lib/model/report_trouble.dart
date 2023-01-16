// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportTrouble {
  String? idReportTrouble;
  String? idCustomer;
  String? idStaff;
  String? idTrouble;
  Timestamp? dateCreated;
  String? dateSolved;
  String? totalMoney;
  bool? isCompensate;
  String? status;
  String? signCus;
  String? signStaff;
  ReportTrouble({
    this.idReportTrouble,
    this.idCustomer,
    this.idStaff,
    this.idTrouble,
    this.dateCreated,
    this.dateSolved,
    this.totalMoney,
    this.isCompensate,
    this.status,
    this.signCus,
    this.signStaff,
  });

  ReportTrouble.fromJson(Map<String, dynamic> json) {
    idReportTrouble = json['idReportTrouble'];
    idCustomer = json['idCustomer'];
    idStaff = json['idStaff'];
    idTrouble = json['idTrouble'];
    dateSolved = json['dateSolved'];
    dateCreated = json['dateCreated'];
    totalMoney = json['totalMoney'];
    isCompensate = json['isCompensate'];
    status = json['status'];
    signCus = json['signCus'];
    signStaff = json['signStaff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idReportTrouble'] = idReportTrouble;
    data['idCustomer'] = idCustomer;
    data['idStaff'] = idStaff;
    data['idTrouble'] = idTrouble;
    data['dateSolved'] = dateSolved;
    data['totalMoney'] = totalMoney;
    data['dateCreated'] = dateCreated;
    data['isCompensate'] = isCompensate;
    data['status'] = status;
    data['signCus'] = signCus;
    data['signStaff'] = signStaff;
    return data;
  }

  ReportTrouble copyWith({
    String? idReportTrouble,
    String? idCustomer,
    String? idStaff,
    String? idTrouble,
    Timestamp? dateCreated,
    String? dateSolved,
    String? totalMoney,
    bool? isCompensate,
    String? status,
    String? signCus,
    String? signStaff,
  }) {
    return ReportTrouble(
      idReportTrouble: idReportTrouble ?? this.idReportTrouble,
      idCustomer: idCustomer ?? this.idCustomer,
      idStaff: idStaff ?? this.idStaff,
      idTrouble: idTrouble ?? this.idTrouble,
      dateCreated: dateCreated ?? this.dateCreated,
      dateSolved: dateSolved ?? this.dateSolved,
      totalMoney: totalMoney ?? this.totalMoney,
      isCompensate: isCompensate ?? this.isCompensate,
      status: status ?? this.status,
      signCus: signCus ?? this.signCus,
      signStaff: signStaff ?? this.signStaff,
    );
  }
}
