import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PaymentVoucher extends Equatable {
  String? idUser;
  String? idImportOrder;
  Timestamp? date;
  String? receiver;
  String? receiverAddress;
  String? totalAmount;
  String? inWord;
  String? description;
  String? chiefAccountant;
  String? cashier;
  String? voteMaker;
  String? idPaymentVoucher;

  PaymentVoucher(
      {this.idUser,
      this.idImportOrder,
      this.date,
      this.receiver,
      this.receiverAddress,
      this.totalAmount,
      this.inWord,
      this.description,
      this.chiefAccountant,
      this.cashier,
      this.voteMaker,
      this.idPaymentVoucher});

  PaymentVoucher.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    idImportOrder = json['idImportOrder'];
    date = json['date'];
    receiver = json['receiver'];
    receiverAddress = json['receiverAddress'];
    totalAmount = json['totalAmount'];
    inWord = json['inWord'];
    description = json['description'];
    chiefAccountant = json['chiefAccountant'];
    cashier = json['cashier'];
    voteMaker = json['voteMaker'];
    idPaymentVoucher = json['idPaymentVoucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['idImportOrder'] = this.idImportOrder;
    data['date'] = this.date;
    data['receiver'] = this.receiver;
    data['receiverAddress'] = this.receiverAddress;
    data['totalAmount'] = this.totalAmount;
    data['inWord'] = this.inWord;
    data['description'] = this.description;
    data['chiefAccountant'] = this.chiefAccountant;
    data['cashier'] = this.cashier;
    data['voteMaker'] = this.voteMaker;
    data['idPaymentVoucher'] = this.idPaymentVoucher;
    return data;
  }

  @override
  List<Object?> get props => [
        idUser,
        idImportOrder,
        date,
        receiver,
        receiverAddress,
        totalAmount,
        inWord,
        description,
        chiefAccountant,
        cashier,
        voteMaker,
        idPaymentVoucher,
      ];
}
