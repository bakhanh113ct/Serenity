import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:serenity/model/order.dart';

import '../model/detail_order.dart';

class DetailOrderRepository {
  final orders = FirebaseFirestore.instance.collection("Order");
  final detailOrders = FirebaseFirestore.instance.collection("DetailOrder");

  final _fireCloud = FirebaseFirestore.instance.collection('DetailOrder');
  getOrder(String idOrder) async {
    List<MyOrder> temp = [];
    await orders.where("idOrder", isEqualTo: idOrder).get().then((value) {
      temp.addAll(value.docs.map((e) => MyOrder.fromJson(e.data())).toList());
    });
    return temp[0];
  }

  getDetailOrder(String idOrder) async {
    List<DetailOrder> listDetailOrder = [];
    detailOrders.where("idOrder", isEqualTo: idOrder).get().then((value) {
      value.docs.forEach((element) {
        listDetailOrder.add(DetailOrder.fromJson(element.data()));
      });
    });
    return listDetailOrder;
  }

  cancelDetailOrder(String idOrder) async {
    await orders.doc(idOrder).update({"status": "Cancelled"});
  }

  Future<List<DetailOrder>> getListDetailOrder(String idOrder) async {
    List<DetailOrder> result = [];
    try {
      final dt = await _fireCloud.get();
      for (var element in dt.docs) {
        var order = DetailOrder.fromJson(element.data());
        if (order.idOrder! == idOrder) {
          result.add(order);
        }
      }
      return result;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  completeDetailOrder(String idOrder) async {
    await orders.doc(idOrder).update({"status": "Completed"});
  }
}
