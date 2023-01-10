import 'dart:io';

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

  updateUser(CustomUser.User oldUser) async {
    CustomUser.User? user;
    await _users.doc('OmCcBlzgrWNHLpsbTZ4r').update(oldUser.toJson());
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
      await user
          ?.updatePassword(password)
          .then((value) => _showDialog(context, true));
    } catch (e) {
      _showDialog(context, false);
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
