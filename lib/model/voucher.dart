import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Voucher extends Equatable{
  String? idVoucher;
  String? name;
  String? content;
  String? percent;
  String? max;
  Timestamp? dateStart;
  Timestamp? dateEnd;

  Voucher(
      {this.idVoucher,
      this.name,
      this.content,
      this.percent,
      this.max,
      this.dateStart,
      this.dateEnd});

  Voucher.fromJson(Map<String, dynamic> json) {
    idVoucher = json['idVoucher'];
    name = json['name'];
    content = json['content'];
    percent = json['percent'];
    max = json['max'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idVoucher'] = this.idVoucher;
    data['name'] = this.name;
    data['content'] = this.content;
    data['percent'] = this.percent;
    data['max'] = this.max;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [idVoucher];
}