import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/model/category.dart';

import '../../../model/customer.dart';
import '../../../model/product.dart';
import '../../../model/voucher.dart';

class CartRepository{
  final categorys=FirebaseFirestore.instance.collection("Category");
  final products=FirebaseFirestore.instance.collection("Product");
  final customers=FirebaseFirestore.instance.collection("Customer");
  final vouchers=FirebaseFirestore.instance.collection("Voucher");
  getCategory()async{
    List<Category> temp=[];
    await categorys.get().then((value) {
      temp.addAll(value.docs.map((e) => Category.fromJson(e.data())).toList());
    });
    return temp;
  }
  getProduct(Category e)async{
    List<Product> temp=[];
    await products.where("category",isEqualTo: e.name).get().then((value) {
      temp.addAll(value.docs.map((e) => Product.fromJson(e.data())).toList());
    });
    return temp;
  }
  getCustomer()async{
    List<Customer> temp=[];
    await customers.get().then((value) {
      temp.addAll(value.docs.map((e) => Customer.fromJson(e.data())).toList());
    });
    return temp;
  }
  getVoucher()async{
    final now = Timestamp.fromDate(DateTime.now());
    List<Voucher> temp=[];
    List<Voucher> temp1=[];
    List<Voucher> temp2=[];
    await vouchers.where("dateStart",isLessThanOrEqualTo: now)
    .get()
    .then((value) {
      value.docs.forEach((element) {
        temp1.add(Voucher.fromJson(element.data()));
       });
    });
    await vouchers.where("dateEnd",isGreaterThanOrEqualTo: now)
    .get()
    .then((value) {
      value.docs.forEach((element) {
        temp2.add(Voucher.fromJson(element.data()));
       });
    });
    temp1.forEach((element) {
      if(temp2.contains(element)){
        temp.add(element);
      }
     });
    return temp;
  }
}