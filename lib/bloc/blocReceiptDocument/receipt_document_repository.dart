import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';
import 'package:serenity/model/product.dart';

import '../../model/receipt_document.dart';

class ReceiptDocumentRepository {
  //get list customers from firebase
  final _fireCloud = FirebaseFirestore.instance.collection('ReceiptDocument');

  Future<List<ReceiptDocument>> get() async {
    List<ReceiptDocument> allReceiptDocuments = [];
    await _fireCloud.get().then((doc) {
      for (var rc in doc.docs) {
          allReceiptDocuments.add(ReceiptDocument.fromJson(rc.data()));
        }
    });
    return allReceiptDocuments;
  }

  Future<void> addReceiptDocument(ReceiptDocument rc) async {
    await _fireCloud.add(rc.toJson()).then((value) {
      rc.idReceiptDocument= value.id;
      updateReceiptDocument(rc);
    });
      rc.listProducts!.forEach((element) async { 
      var product = await ImportBookRepository().getProductImportBook(element.product!.idProduct!);
      await ImportBookRepository().updateImportBook(
          product.copyWith(amount: (int.parse(product.amount!) + element.amount!).toString()));
    });
  }
  
  Future<Object> checkProductExist(Product rc) async {
    bool check = false;
    Product importBook = Product();
    List<Product> allImportBook= await ImportBookRepository().get();

    allImportBook.forEach((element) { 
        if(rc.idProduct == element.idProduct){
          check = true;
          importBook = element;
        }
      });
    return {
      'check': check,
      'importBook': importBook,
    };
  }

  Future<void> updateReceiptDocument(ReceiptDocument rc) async {
    await _fireCloud.doc(rc.idReceiptDocument).update(rc.toJson());
  }

  Future<String> uploadSignReceiptDocument(file) async {
    String imageUrl = '';
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref('signature');
    Reference referenceImageToUpload = referenceRoot.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (error) {
      return '';
    }
  }

  Future<ReceiptDocument> getReceiptDocument(String idReceiptDocument) async {
    ReceiptDocument result = ReceiptDocument();
    await _fireCloud
        .where('idReceiptDocument', isEqualTo: idReceiptDocument)
        .get()
        .then((value) {
      result = ReceiptDocument.fromJson(value.docs.first.data());
    });
    return result;
  }
}
