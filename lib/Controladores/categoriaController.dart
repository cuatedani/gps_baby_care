import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class CategoriaController {
  //Metodo para agregar categorias
  static Future<void> insertCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').add(c.toMap());
  }

  //Metodo para actualizar una categoria
  static Future<void> updateCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').doc(c.idcategory).set(c.toMap());
  }

  //Metodo para eliminar una categoria
  static Future<void> deleteCategoria(Categoria c) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Categorias').doc(c.idcategory).delete();
  }

  //Metodo para obetener todas las categorias
  static Future<List<Categoria>> getAllCategoria() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot =
        await firestore.collection('Categorias').get();

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

  //Metodo para obetener las categorias de Producto
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

  //Metodo para obetner las Categorias de Articulo
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
}
