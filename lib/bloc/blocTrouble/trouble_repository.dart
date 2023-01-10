import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../../model/trouble.dart';

class TroubleRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('Trouble');
  Future<List<Trouble>> get() async {
    List<Trouble> troubleList = [];
    try {
      final trouble = await _fireCloud.get();
      trouble.docs.forEach((element) {
        return troubleList.add(Trouble.fromJson(element.data()));
      });
      return troubleList;
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
      return troubleList;
    }
    catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> addTrouble(Trouble trouble) async {
    await _fireCloud
        .add(trouble.toJson())
        .then((value) {
      trouble.idTrouble = value.id;
      updateTrouble(trouble);
    });
  }

  Future<void> updateTrouble(Trouble trouble) async {
    await _fireCloud
        .doc(trouble.idTrouble)
        .update(trouble.toJson());
  }
  Future<Trouble> getTrouble(String idTrouble) async {
    Trouble result = Trouble();
    await _fireCloud.where('idTrouble', isEqualTo: idTrouble).get().then((value) {
      result =  Trouble.fromJson(value.docs.first.data());
    });
    return result;
  }
}
