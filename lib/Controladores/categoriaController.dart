import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class InstitutoController {
  static Future<void> insertCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categoria').add(c.Registrar());
  }

  static Future<void> updateCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categoria').doc(c.idcategory).set(c.Actualizar());
  }

  static Future<List<Categoria>> getProductoCategoria() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore
        .collection('Categoria')
        .where('type', isEqualTo: 'producto')
        .get();

    List<Categoria> listaCategoria = [];

    querySnapshot.docs.forEach((documento) {
      Categoria oneCategoria = Categoria(
        idcategory: documento.id,
        name: documento['name'],
        type: documento['type'],
      );

      listaCategoria.add(oneCategoria);
    });

    return listaCategoria;
  }

  static Future<List<Categoria>> getArticuloCategoria() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore
        .collection('Categoria')
        .where('type', isEqualTo: 'articulo')
        .get();

    List<Categoria> listaCategoria = [];

    querySnapshot.docs.forEach((documento) {
      Categoria oneCategoria = Categoria(
        idcategory: documento.id,
        name: documento['name'],
        type: documento['type'],
      );

      listaCategoria.add(oneCategoria);
    });

    return listaCategoria;
  }

  static Future<void> deleteInstituto(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categoria').doc(c.idcategory).delete();
  }
}