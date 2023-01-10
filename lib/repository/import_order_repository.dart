import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/model/import_order.dart';

class ImportOrderRepository {
  // final _users = FirebaseFirestore.instance.collection('ImportOrder');

  Stream<List<ImportOrder>> getImportOrder() {
    return FirebaseFirestore.instance
        .collection('ImportOrder')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => ImportOrder.fromJson(e.data())).toList();
    });
  }
}
