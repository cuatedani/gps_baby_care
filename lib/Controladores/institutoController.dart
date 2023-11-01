import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';

class InstitutoController {
  static Future<void> insertInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').add(i.Registrar());
  }

  static Future<void> updateInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstitute).set(i.Actualizar());
  }

  static Future<List<Instituto>> getallInstituto() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Instituto').get();
    List<Instituto> listaInstituto = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Instituto oneInstituto = Instituto(
        idinstitute: documento.id,
        name: documento['name'],
        phone: documento['phone'],
        address: documento['address'],
        description: documento['description'],
        logo: documento['logo'],
      );

      listaInstituto.add(oneInstituto);
    });

    return listaInstituto;
  }

  static Future<void> deleteInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstitute).delete();
  }
}
