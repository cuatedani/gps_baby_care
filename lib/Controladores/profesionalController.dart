import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';

class ProfesionalController {
  static Future<void> insertProfesional(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').add(p.Registrar());
  }

  static Future<void> updateInstituto(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').doc(p.idprof).set(p.Actualizar());
  }

  static Future<List<Profesional>> getallProfesional() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Profesional').get();
    List<Profesional> listaProfesional = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Profesional oneProfesional = Profesional(
        idprof: documento.id,
        iduser: documento['iduser'],
        idinstitute: documento['idinstitute'],
        occupation: documento['occupation'],

      );

      listaProfesional.add(oneProfesional);
    });

    return listaProfesional;
  }

  static Future<Profesional> getOneProfesional(String? iduser) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Profesional')
        .where('iduser', isEqualTo: iduser)
        .get();

    final documento = querySnapshot.docs.first;

    return Profesional(
      idprof: documento.id,
      iduser: documento['iduser'],
      idinstitute: documento['idinstitute'],
      occupation: documento['occupation'],
    );
  }

  static Future<void> deleteProfesional(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').doc(p.idprof).delete();
  }
}
