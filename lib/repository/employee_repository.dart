import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:serenity/model/User.dart' as user_model;

class EmployeeRepository {
  static final EmployeeRepository _employeeRepository =
      EmployeeRepository._internal();
  factory EmployeeRepository() {
    return _employeeRepository;
  }
  EmployeeRepository._internal();

  final _users = FirebaseFirestore.instance.collection('User');
  final storageRef = FirebaseStorage.instance.ref();
  Stream<List<user_model.User>> getEmployee() {
    return FirebaseFirestore.instance
        .collection('User')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => user_model.User.fromJson(e.data())).toList();
    });
  }

  addNewEmployee(user_model.User user, String password) async {
    UserCredential userCredential = await register(user.email!, password);
    // print(userCredential.user!.uid);
    String imageLink =
        await _uploadAvatar(userCredential.user!.uid, File(user.image!));
    _users
        .doc(userCredential.user!.uid)
        .set(user.toJson())
        .then((value) => _users.doc(userCredential.user!.uid).update({
              'idUser': userCredential.user!.uid,
              'image': imageLink,
            }));
  }

  updateEmployee(user_model.User user) async {
    if (user.image!.startsWith('h')) {
      _users.doc(user.idUser).update(user.toJson());
    } else {
      File file = File(user.image!);
      String imageLink = await _uploadAvatar(user.idUser!, file);
//2ZBt0XAkEvaDfYLIX2o0upGKMRE3
      _users
          .doc(user.idUser)
          .set(user.toJson())
          .then((value) => _users.doc(user.idUser).update({
                'image': imageLink,
              }));
    }
  }

  resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // print(email);
  }

  Future<UserCredential> register(String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // print(value.user!.uid.toString());
        await app.delete();
        return Future.sync(() => value);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      // Do something with exception. This try/catch is here to make sure
      // that even if the user creation fails, app.delete() runs, if is not,
      // next time Firebase.initializeApp() will fail as the previous one was
      // not deleted.
    }

    return Future.sync(() => userCredential!);
  }

  Future<String> _uploadAvatar(String id, File file) async {
    final mountainsRef = storageRef.child(id);
    try {
      print('update avatar user');
      await mountainsRef.putFile(file);
      final imageUrl = await mountainsRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // ...
      print(e);
    }
    return '';
  }
}
