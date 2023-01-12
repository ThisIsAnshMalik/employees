import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EmployeeProvider with ChangeNotifier {
  Stream<QuerySnapshot> getEmployeeData() {
    return FirebaseFirestore.instance
        .collection('employeesData')
        .snapshots(includeMetadataChanges: true);
  }
}
