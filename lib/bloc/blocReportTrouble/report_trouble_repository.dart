import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serenity/bloc/bloc_exports.dart';

import '../../model/report_trouble.dart';
import '../../model/trouble.dart';

class ReportTroubleRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('ReportTrouble');
  Future<List<ReportTrouble>> get() async {
    List<ReportTrouble> reportTroubleList = [];
    try {
      final reportTrouble = await _fireCloud.get();
      reportTrouble.docs.forEach((element) {
        return reportTroubleList.add(ReportTrouble.fromJson(element.data()));
      });
      return reportTroubleList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return reportTroubleList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addReportTrouble(ReportTrouble reportTrouble) async {
    await _fireCloud.add(reportTrouble.toJson()).then((value) {
      reportTrouble.idReportTrouble = value.id;
      updateReportTrouble(reportTrouble);
    });
  }

  Future<void> updateReportTrouble(ReportTrouble reportTrouble) async {
    await _fireCloud.doc(reportTrouble.idReportTrouble).update(reportTrouble.toJson());
  }

  Future<ReportTrouble> getReportTrouble(String idReportTrouble) async {
    ReportTrouble result = ReportTrouble();
    await _fireCloud
        .where('idReportTrouble', isEqualTo: idReportTrouble)
        .get()
        .then((value) {
      result = ReportTrouble.fromJson(value.docs.first.data());
    });
    return result;
  }

   Future<ReportTrouble> getReportTroubleByIdTrouble(String idTrouble) async {
    ReportTrouble result = ReportTrouble();
    await _fireCloud
        .where('idTrouble', isEqualTo: idTrouble)
        .get()
        .then((value) {
      result = ReportTrouble.fromJson(value.docs.first.data());
    });
    return result;
  }
  
  Future<String> uploadAndGetSignature(file) async {
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
}
