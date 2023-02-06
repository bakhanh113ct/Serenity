import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/User.dart' as CustomUser;

class UserRepository {
  final _users = FirebaseFirestore.instance.collection('User');
  final _idUser = FirebaseAuth.instance.currentUser!.uid;
  final storageRef = FirebaseStorage.instance.ref();
  getUser() async {
    CustomUser.User? user;
    await _users.where('idUser', isEqualTo: _idUser).get().then((value) {
      user = CustomUser.User.fromJson(value.docs.first.data());
    });
    return user;
  }

  getUserByIdUser(String idUser) async {
    CustomUser.User? user;
    await _users.where('idUser', isEqualTo: idUser).get().then((value) {
      user = CustomUser.User.fromJson(value.docs.first.data());
    });
    return user;
  }

  updateUser(CustomUser.User oldUser) async {
    CustomUser.User? user;
    await _users.doc(oldUser!.idUser).update(oldUser.toJson());
    print('update User');
    return user;
  }

  updateAvatar(File file) async {
    final mountainsRef = storageRef.child("avatarKhanh_test.jpg");
    try {
      print('update avatar user');
      await mountainsRef.putFile(file);
      final imageUrl = await mountainsRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // ...
      print(e);
    }
  }

  changePasswordUser(String password, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    print('111');
    try {
      await user?.updatePassword(password).then((value) => Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 16),
            borderRadius: BorderRadius.circular(8),
            flushbarStyle: FlushbarStyle.FLOATING,
            title: 'Notification',
            message: 'Update password successful',
            duration: const Duration(seconds: 3),
          ).show(context));
    } catch (e) {
      if (e.toString() ==
          '[firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request.') {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 16),
          borderRadius: BorderRadius.circular(8),
          flushbarStyle: FlushbarStyle.FLOATING,
          title: 'Fail',
          message: 'Please login again to change password',
          duration: const Duration(seconds: 3),
        ).show(context);
      } else if (e.toString() ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 16),
          borderRadius: BorderRadius.circular(8),
          flushbarStyle: FlushbarStyle.FLOATING,
          title: 'Fail',
          message: 'Password should be at least 6 characters',
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 16),
          borderRadius: BorderRadius.circular(8),
          flushbarStyle: FlushbarStyle.FLOATING,
          title: 'Fail',
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ).show(context);
      }

      print(e);
    }
  }

  _showDialog(BuildContext context, bool status) {
    // status: false: error, true: success
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Notification'),
        content: Text(
            status ? 'Change password successful' : 'Change password fail'),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text(
          //     'Cancel',
          //     style: TextStyle(color: Colors.black),
          //   ),
          // ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Yes');
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
