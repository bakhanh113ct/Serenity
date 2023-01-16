import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/customer.dart';

class CustomerRepository {
  //get list customers from firebase
  final _fireCloud = FirebaseFirestore.instance.collection('Customer');

  Future<List<Customer>> get() async {
    List<Customer> allCustomers = [];
    await _fireCloud.get().then((doc) {
       doc.docs.forEach(
      (customer) {
        allCustomers.add(Customer.fromJson(customer.data()));
      },
    );
    });
    return allCustomers;
  }

  Future<void> addCustomer(Customer customer) async{
    await _fireCloud
      .add(customer.toJson())
      .then((value) {
        customer.idCustomer = value.id;
        updateCustomer(customer);
      });
    
  }
 Future<void>  updateCustomer(Customer customer) async {
     await _fireCloud
        .doc(customer.idCustomer)
        .update(customer.toJson());
  }
  Future<String>  uploadAndGetImageUrl(file) async {
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

  Future<Customer> getCustomer(String idCustomer) async {
    Customer result = Customer();
    await _fireCloud
        .where('idCustomer', isEqualTo: idCustomer)
        .get()
        .then((value) {
      result = Customer.fromJson(value.docs.first.data());
    });
    return result;
  }
}
