import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/User.dart' as CustomUser;
class UserRepository{
  final _users= FirebaseFirestore.instance.collection('User');
  final _idUser=FirebaseAuth.instance.currentUser!.uid;
  getUser()async{
    CustomUser.User? user;
    await _users.where('idUser',isEqualTo: _idUser).get().then((value) {
      user=CustomUser.User.fromJson(value.docs.first.data());
    });
    return user;
  }
}