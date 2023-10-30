import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';

class usuarioController {
  static Future<void> insertUsuario(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').add(i.toMap());
  }

  static Future<void> updateInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstituto).set(i.toMap());
  }

  static Future<List<Instituto>> getallInstituto() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Instituto').get();
    List<Instituto> listaInstituto = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Instituto oneInstituto = Instituto(
        idinstituto: documento.id,
        nombre: documento['nombre'],
        telefono: documento['telefono'],
        direccion: documento['direccion'],
        descripcion: documento['descripcion'],
        logo: documento['logo'],
      );

      listaInstituto.add(oneInstituto);
    });

    return listaInstituto;
  }

  static Future<void> deleteInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstituto).delete();
  }
}
