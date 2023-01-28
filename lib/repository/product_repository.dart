import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/category.dart';
import '../model/product.dart';

class ProductRepository{
  final categorys=FirebaseFirestore.instance.collection("Category");
  final products=FirebaseFirestore.instance.collection("Product");
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
}