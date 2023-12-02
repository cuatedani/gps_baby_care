import 'package:firebase_storage/firebase_storage.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';

class InstitutoController {

  //Metodo para insertar un Instituto
  static Future<Instituto> insertInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentReference docRef = await DB.collection('Instituto').add(i.toMap());
    try{
      // Obtener el ID asignado por Firebase
      i.idinstitute = docRef.id;

      //Retornamos el instituto
      return i;
    } catch (e) {
      print("Aparecio el Error: ${e.toString()}");
      return i;
    }
  }

  //Metodo para Actualizar un Instituto
  static Future<void> updateInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstitute).set(i.toMap());
  }

  //Metodo para Obtener todos los Insitutos que no estan Eliminados
  static Future<List<Instituto>> getAllInstituto() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot =
    await DB.collection('Instituto').where('isdeleted', isEqualTo: false).get();
    List<Instituto> listaInstituto = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      ImagenModel InsLogo = ImagenModel(
          name: documento['logo']['name'], url: documento['logo']['url']);

      Instituto oneInstituto = Instituto(
        idinstitute: documento.id,
        name: documento['name'],
        phone: documento['phone'],
        address: documento['address'],
        description: documento['description'],
        logo: InsLogo,
        isdeleted: documento['isdeleted'],
      );

      listaInstituto.add(oneInstituto);
    });

    return listaInstituto;
  }

  //Metodo para Obtener un Instituto por ID
  static Future<Instituto> getOneInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentSnapshot doc = await DB.collection('Instituto').doc(i.idinstitute).get();
    List<Instituto> listaInstituto = [];

    ImagenModel InsLogo = ImagenModel(
        name: doc['logo']['name'], url: doc['logo']['url']);

    Instituto oneInstituto = Instituto(
      idinstitute: doc.id,
      name: doc['name'],
      phone: doc['phone'],
      address: doc['address'],
      description: doc['description'],
      logo: InsLogo,
      isdeleted: doc['isdeleted'],
    );

    return oneInstituto;
  }

  //Metodo para Borrar un Instituto Definitivamente
  static Future<void> deleteInstituto(Instituto i) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Instituto').doc(i.idinstitute).delete();
  }
}
