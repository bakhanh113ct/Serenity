import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/product.dart';


class ImportBookRepository {
  //get list customers from firebase
  final _fireCloud = FirebaseFirestore.instance.collection('Product');

  Future<List<Product>> get() async {
    List<Product> allImportBooks = [];
    await _fireCloud.get().then((doc) {
      doc.docs.forEach(
        (e) {
          allImportBooks.add(Product.fromJson(e.data()));
        },
      );
    });
    return allImportBooks;
  }
  Future<void> addImportBook(Product ip) async {
    await _fireCloud.add(ip.toJson()).then((value) {
      updateImportBook(ip.copyWith(idProduct: value.id));
    });
  }

  Future<void> updateImportBook(Product ip) async {
    await _fireCloud
        .doc(ip.idProduct)
        .update(ip.toJson());
  }

   Future<Product> getProductImportBook(String idProduct) async {
    Product result = Product();
    await _fireCloud
        .where('idProduct', isEqualTo: idProduct)
        .get()
        .then((value) {
      result = Product.fromJson(value.docs.first.data());
    });
    return result;
  }
}
