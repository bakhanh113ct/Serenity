import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:serenity/model/detailOrder.dart';
import 'package:serenity/model/product.dart';


class DetailOrderRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('DetailOrder');
 
  Future<List<DetailOrder>> getDetailOrder(String idOrder) async {
    List<DetailOrder> result = [];
    try {
      final dt = await _fireCloud.get();
      for (var element in dt.docs) {
        var order = DetailOrder.fromJson(element.data());
        if(order.idOrder! == idOrder){
          result.add(order);
        }
      }
      return result;
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
      return result;
    }
    catch (e){
      throw Exception(e.toString());
    }
  }
}
