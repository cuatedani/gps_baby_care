import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';

class ArticuloController {
  static Future<void> insertArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Articulo').add(a.Registrar());
  }

  static Future<void> updateArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Articulo').doc(a.idarticle).set(a.Actualizar());
  }

  static Future<List<Articulo>> getAllArticulo() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore.collection('Articulo').get();

    List<Articulo> listaArticulo = [];

    querySnapshot.docs.forEach((documento) {
      Articulo oneArticulo = Articulo(
          idarticle: documento.id,
          idprof: documento['idprof'],
          date: documento['date'],
          title: documento['title'],
          content: documento['content'],
          category: documento['category'],
          gallery: documento['gallery']);

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

    querySnapshot.docs.forEach((documento) {
      Articulo oneArticulo = Articulo(
          idarticle: documento.id,
          idprof: documento['idprof'],
          date: documento['date'],
          title: documento['title'],
          content: documento['content'],
          category: documento['category'],
          gallery: documento['gallery']);

      listaArticulo.add(oneArticulo);
    });

    return listaArticulo;
  }
}
