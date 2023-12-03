import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';

class ProfesionalController {
  //Inserta un Nuevo Profesional
  static Future<void> insertProfesional(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').add(p.toMap());
  }

  //Actualiza un Profesional
  static Future<void> updateInstituto(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').doc(p.idprof).set(p.toMap());
  }

  //Obtiene Todos Los Profesionales
  static Future<List<Profesional>> getAllProfesional() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Profesional')
        .where('isdeleted', isEqualTo: false)
        .get();
    List<Profesional> listaProfesional = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Profesional oneProfesional = Profesional(
          idprof: documento.id,
          iduser: documento['iduser'],
          idinstitute: documento['idinstitute'],
          occupation: documento['occupation'],
          isdeleted: documento['isdeleted']);

      listaProfesional.add(oneProfesional);
    });

    return listaProfesional;
  }

  //Obtiene Todos los Profesionales de un Instituto
  static Future<List<Profesional>> getInstProfesional(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Profesional')
        .where('idinstitute', isEqualTo: i.idinstitute)
        .where('isdeleted', isEqualTo: false)
        .get();
    List<Profesional> listaProfesional = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Profesional oneProfesional = Profesional(
          idprof: documento.id,
          iduser: documento['iduser'],
          idinstitute: documento['idinstitute'],
          occupation: documento['occupation'],
          isdeleted: documento['isdeleted']);

      listaProfesional.add(oneProfesional);
    });

    return listaProfesional;
  }

  //Obtiene un Profesional por su Usuario
  static Future<Profesional> getOneProfesional(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Profesional')
        .where('iduser', isEqualTo: u.iduser)
        .where('isdeleted', isEqualTo: false)
        .get();

    final documento = querySnapshot.docs.first;

    return Profesional(
        idprof: documento.id,
        iduser: documento['iduser'],
        idinstitute: documento['idinstitute'],
        occupation: documento['occupation'],
        isdeleted: documento['isdeleted']);
  }

  //Elimina Definitivamente un Profesional
  static Future<void> deleteProfesional(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Profesional').doc(p.idprof).delete();
  }
}
