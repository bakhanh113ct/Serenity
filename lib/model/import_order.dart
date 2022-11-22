import 'package:cloud_firestore/cloud_firestore.dart';

class ImportOrder {
  /// Creates the employee class with required details.
  ImportOrder(this.id, this.supplierName, this.dateCreated, this.status,
      this.price, this.note);

  /// Id of an employee.
  final String id;

  /// Name of an employee.
  final String supplierName;

  /// Designation of an employee.
  final Timestamp dateCreated;

  /// Salary of an employee.
  final String status;

  final double price;

  final String note;
}
