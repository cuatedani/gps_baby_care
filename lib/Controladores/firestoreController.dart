import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreController {
  static Future<FirebaseFirestore> abrirFireStore() async {
    return FirebaseFirestore.instance;
  }
}
