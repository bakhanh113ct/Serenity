import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/blocExportBook/export_book_repository.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';
import 'package:serenity/model/export_product.dart';

import '../../model/delivery_receipt.dart';
import '../../model/receipt_document.dart';
import '../blocOrder/order_repository.dart';

class DeliveryReceiptRepository {
  //get list customers from firebase
  final _fireCloud = FirebaseFirestore.instance.collection('DeliveryReceipt');

  Future<List<DeliveryReceipt>> get() async {
    List<DeliveryReceipt> allDeliveryReceipts = [];
    await _fireCloud.get().then((doc) {
      for (var rc in doc.docs) {
        allDeliveryReceipts.add(DeliveryReceipt.fromJson(rc.data()));
      }
    });
    return allDeliveryReceipts;
  }

  Future<void> addDeliveryReceipt(DeliveryReceipt rc) async {
    await _fireCloud.add(rc.toJson()).then((value) {
      rc.idDeliveryReceipt = value.id;
      updateDeliveryReceipt(rc);
    });
    rc.listProducts!.forEach((element) async {
      //minus product in warehouse
      var product = await ImportBookRepository().getProductImportBook(element.idProduct!);
      await ImportBookRepository().updateImportBook(product.copyWith(
          amount: (int.parse(product.amount!) - int.parse(element.amount!)).toString()));

      //add product to export book
      var ep = ExportProduct(
        amount: element.amount,
        category: element.category,
        content: element.content,
        historicalCost: element.historicalCost,
        idExportProduct: element.idProduct,
        image: element.image,
        name: element.name,
        price: element.price,
        idOrder: rc.idOrder,
        dateExport: rc.dateCreated,
      );
      await ExportBookRepository().addExportBook(ep);

      // update status of order
      var order = await OrderRepository().getOrderById(rc.idOrder!);
      await OrderRepository().updateOrder(order.copyWith(status: 'Completed'));
    });
  }

  Future<void> updateDeliveryReceipt(DeliveryReceipt rc) async {
    await _fireCloud.doc(rc.idDeliveryReceipt).update(rc.toJson());
  }

  Future<String> uploadSignDeliveryReceipt(file) async {
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

  Future<DeliveryReceipt> getDeliveryReceipt(String idDeliveryReceipt) async {
    DeliveryReceipt result = DeliveryReceipt();
    await _fireCloud
        .where('idDeliveryReceipt', isEqualTo: idDeliveryReceipt)
        .get()
        .then((value) {
      result = DeliveryReceipt.fromJson(value.docs.first.data());
    });
    return result;
  }
}
