import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/model/product_import_order.dart';

class ImportOrder extends Equatable {
  String? nameA;
  String? addressA;
  String? phoneA;
  String? bankA;
  String? atBankA;
  String? authorizedPersonA;
  String? positionA;
  String? noAuthorizationA;
  Timestamp? dateAuthorizationA;
  String? nameB;
  String? addressB;
  String? phoneB;
  String? bankB;
  String? atBankB;
  String? authorizedPersonB;
  String? positionB;
  String? noAuthorizationB;
  Timestamp? dateAuthorizationB;
  String? pursuant;
  Timestamp? dateCreated;
  String? atPlace;
  String? note;
  String? totalPrice;
  String? idImportOrder;
  String? status;
  List<ProductImportOrder>? listProduct;
  List<bool>? listCheck;

  ImportOrder({
    this.nameA,
    this.addressA,
    this.phoneA,
    this.bankA,
    this.atBankA,
    this.authorizedPersonA,
    this.positionA,
    this.noAuthorizationA,
    this.dateAuthorizationA,
    this.nameB,
    this.addressB,
    this.phoneB,
    this.bankB,
    this.atBankB,
    this.authorizedPersonB,
    this.positionB,
    this.noAuthorizationB,
    this.dateAuthorizationB,
    this.pursuant,
    this.dateCreated,
    this.atPlace,
    this.note,
    this.totalPrice,
    this.idImportOrder,
    this.status,
    this.listProduct,
    this.listCheck,
  });

  ImportOrder.fromJson(Map<String, dynamic> json) {
    nameA = json['nameA'];
    addressA = json['addressA'];
    phoneA = json['phoneA'];
    bankA = json['bankA'];
    atBankA = json['atBankA'];
    authorizedPersonA = json['authorizedPersonA'];
    positionA = json['positionA'];
    noAuthorizationA = json['noAuthorizationA'];
    dateAuthorizationA = json['dateAuthorizationA'];
    nameB = json['nameB'];
    addressB = json['addressB'];
    phoneB = json['phoneB'];
    bankB = json['bankB'];
    atBankB = json['atBankB'];
    authorizedPersonB = json['authorizedPersonB'];
    positionB = json['positionB'];
    noAuthorizationB = json['noAuthorizationB'];
    dateAuthorizationB = json['dateAuthorizationB'];
    pursuant = json['pursuant'];
    dateCreated = json['dateCreated'];
    atPlace = json['atPlace'];
    note = json['note'];
    totalPrice = json['totalPrice'];
    idImportOrder = json['idImportOrder'];
    status = json['status'];
    if (json['listProduct'] != null) {
      listProduct = <ProductImportOrder>[];
      json['listProduct'].forEach((v) {
        listProduct!.add(ProductImportOrder.fromJson(v));
      });
    }
    listCheck = json['listCheck'].cast<bool>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameA'] = this.nameA;
    data['addressA'] = this.addressA;
    data['phoneA'] = this.phoneA;
    data['bankA'] = this.bankA;
    data['atBankA'] = this.atBankA;
    data['authorizedPersonA'] = this.authorizedPersonA;
    data['positionA'] = this.positionA;
    data['noAuthorizationA'] = this.noAuthorizationA;
    data['dateAuthorizationA'] = this.dateAuthorizationA;
    data['nameB'] = this.nameB;
    data['addressB'] = this.addressB;
    data['phoneB'] = this.phoneB;
    data['bankB'] = this.bankB;
    data['atBankB'] = this.atBankB;
    data['authorizedPersonB'] = this.authorizedPersonB;
    data['positionB'] = this.positionB;
    data['noAuthorizationB'] = this.noAuthorizationB;
    data['dateAuthorizationB'] = this.dateAuthorizationB;
    data['pursuant'] = this.pursuant;
    data['dateCreated'] = this.dateCreated;
    data['atPlace'] = this.atPlace;
    data['note'] = this.note;
    data['totalPrice'] = this.totalPrice;
    data['idImportOrder'] = this.idImportOrder;
    data['status'] = this.status;
    if (this.listProduct != null) {
      data['listProduct'] = this.listProduct!.map((v) => v).toList();
    }
    data['listCheck'] = this.listCheck;

    return data;
  }

  @override
  List<Object?> get props => [
        nameA,
        addressA,
        phoneA,
        bankA,
        atBankA,
        authorizedPersonA,
        positionA,
        noAuthorizationA,
        dateAuthorizationA,
        nameB,
        addressB,
        phoneB,
        bankB,
        atBankB,
        authorizedPersonB,
        positionB,
        noAuthorizationB,
        dateAuthorizationB,
        pursuant,
        dateCreated,
        atPlace,
        note,
        totalPrice,
        idImportOrder,
        status,
        listProduct,
        listCheck,
      ];
}
