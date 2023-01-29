import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/model/product_import_order.dart';

class ImportOrderRepository {
  final _importOrder = FirebaseFirestore.instance.collection('ImportOrder');

  Stream<List<ImportOrder>> getImportOrder() {
    return FirebaseFirestore.instance
        .collection('ImportOrder')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => ImportOrder.fromJson(e.data())).toList();
    });
  }

  Future<List<ImportOrder>> getListImportOrder() async {
    final _fireCloud = FirebaseFirestore.instance.collection('ImportOrder');
    List<ImportOrder> importOrderList = [];
    try {
      final ip = await _fireCloud.get();
      ip.docs.forEach((element) {
        return importOrderList.add(ImportOrder.fromJson(element.data()));
      });
      return importOrderList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return importOrderList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ImportOrder> getIO(String idImportOrder) async {
    final _fireCloud = FirebaseFirestore.instance.collection('ImportOrder');
    ImportOrder result = ImportOrder();
    await _fireCloud
        .where('idImportOrder', isEqualTo: idImportOrder)
        .get()
        .then((value) {
      result = ImportOrder.fromJson(value.docs.first.data());
    });
    return result;
  }

  void updateStateImportOrder(String id, String state, List<bool> listCheck,
      List<ProductImportOrder> products) {
    _importOrder.doc(id).update({
      'status': state,
      'listCheck': listCheck,
      'listProduct': products.map((e) => e.toJson()).toList(),
    });
  }

  void completeImportOrder(id, state) {
    _importOrder.doc(id).update({
      'status': state,
    });
  }
}
