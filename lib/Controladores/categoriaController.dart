import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class CategoriaController {
  static Future<void> insertCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').add(c.toMap());
  }

  static Future<void> updateCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').doc(c.idcategory).set(c.toMap());
  }

  static Future<List<Categoria>> getProductoCategoria() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore
        .collection('Categorias')
        .where('type', isEqualTo: 'Producto')
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
        .collection('Categorias')
        .where('type', isEqualTo: 'Articulo')
        .get();
    List<Categoria> listaCategoria = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Categoria oneCategoria = Categoria(
        idcategory: documento.id,
        name: documento['name'],
        type: documento['type'],
      );

      listaCategoria.add(oneCategoria);
    });

    return listaCategoria;
  }

  static Future<void> deleteCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').doc(c.idcategory).delete();
  }
}