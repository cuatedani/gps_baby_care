import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/citaModel.dart';
import 'firestoreController.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class CitaController {
  static Future<void> insertCita(Cita cita) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentReference docRef = await DB.collection('Citas').add(cita.toMap());

    try {
      // Obtener el ID asignado por Firebase
      cita.idCita = docRef.id;

      await docRef.update({'idCita': cita.idCita});
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  static Future<List<Cita>> getAllCitas() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Citas').get();

    List<Cita> listaCitas = [];

    querySnapshot.docs.forEach((documento) {
      Cita cita = Cita(

        idCita: documento.id,
        idProfesional: documento['idProfesional'],
        idUsuario: documento['idUsuario'],
        fecha: documento['fecha'],
        motivo: documento['motivo']
      );

      listaCitas.add(cita);
    });

    return listaCitas;
  }
  static Future<List<Cita>> getCitasByUserId(String idUsuario) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Citas').where('idUsuario', isEqualTo: idUsuario).get();

    List<Cita> listaCitas = [];

    querySnapshot.docs.forEach((documento) {
      Cita cita = Cita(
          idCita: documento.id,
          idProfesional: documento['idProfesional'],
          idUsuario: documento['idUsuario'],
          fecha: DateTime.parse(documento['fecha']),
          motivo: documento['motivo']
      );

      listaCitas.add(cita);
    });

    return listaCitas;
  }
}
