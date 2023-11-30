import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreController.dart';
import 'package:gps_baby_care/Modelos/categoriaProductoModel.dart';

class CategoriaController {
  static Future<List<CategoriaP>> getallCategorias() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('CategoriaP').get();
    List<CategoriaP> listaCategorias = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      CategoriaP categorias = CategoriaP(
          id: documento.id,
          nombre: documento['nombre'],
          );

      listaCategorias.add(categorias);
    });

    return listaCategorias;
  }
}
