import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreHelper {
  CloudFireStoreHelper._();

  static final CloudFireStoreHelper cloudFireStoreHelper =
      CloudFireStoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addEmployee({required Map<String, dynamic> emp_details}) async {
    await firebaseFirestore
        .collection("employee")
        .doc("${emp_details['name']}")
        .set(emp_details);
  }
}
