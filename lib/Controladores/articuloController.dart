import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'firestoreController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';

class ArticuloController {
  static Future<void> insertArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Articulo').add(a.toMap());
  }

  static Future<void> updateArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Articulo').doc(a.idarticle).set(a.toMap());
  }

  static Future<List<Articulo>> getAllArticulo() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore.collection('Articulo').get();

    List<Articulo> listaArticulo = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> listaCategorias = [];

      QuerySnapshot<Map<String, dynamic>> categoriaSnapshot =
          await documento.reference.collection('categories').get();

      listaCategorias = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      Articulo oneArticulo = Articulo(
        idarticle: documento.id,
        idprof: documento['idprof'],
        date: documento['date'],
        title: documento['title'],
        content: documento['content'],
        categories: listaCategorias,
        gallery: (documento.get('gallery') as List<dynamic>).cast<String>(),
      );

      listaArticulo.add(oneArticulo);
    });

    return listaArticulo;
  }

  static Future<List<Articulo>> getProfArticulo(String idprof) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore
        .collection('Articulo')
        .where('idprof', isEqualTo: idprof)
        .get();

    List<Articulo> listaArticulo = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> listaCategorias = [];

      QuerySnapshot<Map<String, dynamic>> categoriaSnapshot =
          await documento.reference.collection('categories').get();

      listaCategorias = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      Articulo oneArticulo = Articulo(
        idarticle: documento.id,
        idprof: documento['idprof'],
        date: documento['date'],
        title: documento['title'],
        content: documento['content'],
        categories: listaCategorias,
        gallery: (documento.get('gallery') as List<dynamic>).cast<String>(),
      );

      listaArticulo.add(oneArticulo);
    });

    return listaArticulo;
  }
}
