
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/export_product.dart';

class ExportBookRepository {
  //get list customers from firebase
  final _fireCloud = FirebaseFirestore.instance.collection('ExportBook');

  Future<List<ExportProduct>> get() async {
    List<ExportProduct> allExportBooks = [];
    await _fireCloud.get().then((doc) {
      doc.docs.forEach(
        (e) {
          allExportBooks.add(ExportProduct.fromJson(e.data()));
        },
      );
    });
    return allExportBooks;
  }

  Future<void> addExportBook(ExportProduct ip) async {
    await _fireCloud.add(ip.toJson()).then((value) {
      updateExportBook(ip.copyWith(idExportProduct: value.id));
    });
  }

  Future<void> updateExportBook(ExportProduct ip) async {
    await _fireCloud.doc(ip.idExportProduct).update(ip.toJson());
  }

  Future<ExportProduct> getExportProduct(String idExportProduct) async {
    ExportProduct result = ExportProduct();
    await _fireCloud
        .where('idExportProduct', isEqualTo: idExportProduct)
        .get()
        .then((value) {
      result = ExportProduct.fromJson(value.docs.first.data());
    });
    return result;
  }
}
