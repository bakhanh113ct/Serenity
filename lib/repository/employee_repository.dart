import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/model/User.dart';

class EmployeeRepository {
  final _users = FirebaseFirestore.instance.collection('User');

  Stream<List<User>> getEmployee() {
    // List<User> result = [];
    // await _users.get().then((value) {
    //   value.docs.forEach((element) {
    //     result.add(User.fromJson(element.data()));
    //   });
    // });
    // return result;
    return FirebaseFirestore.instance
        .collection('User')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => User.fromJson(e.data())).toList();
    });
  }

  addNewEmployee(User user) {
    _users.add(user.toJson());
  }
}
