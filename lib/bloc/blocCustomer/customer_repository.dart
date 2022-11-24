import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/Customer.dart';

class CustomerRepository {
  getListCustomers() async {
    List<Customer> allCustomers = [];
    await FirebaseFirestore.instance.collection("Customers").get().then((doc) {
       doc.docs.forEach(
      (customer) {
        allCustomers.add(Customer.fromMap(customer.data()).copyWith(id: customer.id));
      },
    );
    });
    return allCustomers;
  }

  uploadAndGetImageUrl(file) async {
    String imageUrl = '';
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref('imagesAvatar');
    Reference referenceImageToUpload = referenceRoot.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (error) {
      return '';
    }
  }
}
