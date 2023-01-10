// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Trouble {
  String? idTrouble;
  String? nameCustomer;
  Timestamp? dateCreated;
  String? dateSolved;
  String? description;
  String? idCustomer;
  String? status;

  Trouble({
    this.idTrouble,
    this.nameCustomer,
    this.dateCreated,
    this.dateSolved,
    this.description,
    this.idCustomer,
    this.status, 
  });

  Trouble.fromJson(Map<String, dynamic> json) {
    idTrouble = json['idTrouble'];
    nameCustomer = json['nameCustomer'];
    dateSolved= json['dateSolved'];
    dateCreated = json['dateCreated'];
    description = json['description'];
    idCustomer = json['idCustomer'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTrouble'] = idTrouble;
    data['nameCustomer'] = nameCustomer;
    data['dateSolved'] = dateSolved ;
    data['description'] = description;
    data['dateCreated'] = dateCreated;
    data['idCustomer'] = idCustomer;
    data['status'] = status;
    return data;
  }

  Trouble copyWith({
    String? idTrouble,
    String? nameCustomer,
    Timestamp? dateCreated,
    String? description,
    String? dateSolved,
    String? idCustomer,
    String? status,
  }) {
    return Trouble(
      idTrouble: idTrouble ?? this.idTrouble,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      dateCreated: dateCreated ?? this.dateCreated,
      dateSolved: dateSolved ?? this.dateSolved,
      description: description ?? this.description,
      idCustomer: idCustomer ?? this.idCustomer,
      status: status ?? this.status,
    );
  }
}
