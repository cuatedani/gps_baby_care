import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'firestoreController.dart';

class ArticuloController {
  //Insertar un articulo en la base de datos
  static Future<void> insertArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();

    try {
      DocumentReference docRef = await DB.collection('Articulo').add(a.toMap());

      if (a.gallery!.isNotEmpty) {
        // Insertar imágenes en la subcolección 'gallery'
        await Future.forEach(a.gallery!, (imagen) async {
          await docRef.collection('gallery').add(imagen.toMap());
        });
      }

      if (a.categories!.isNotEmpty) {
        // Insertar categorías en la subcolección 'categories'
        await Future.forEach(a.categories!, (categoria) async {
          await docRef.collection('categories').add(categoria.toMap());
        });
      }
    } catch (e) {}
  }

  //Actualizar un articulo en la Base de Datos
  static Future<void> updateArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Articulo').doc(a.idarticle).set(a.toMap());
  }

  //Obtener una Lista con Todos los Articulos
  static Future<List<Articulo>> getAllArticulo() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore.collection('Articulo').get();

    List<Articulo> listaArticulo = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> listaCategorias = [];
      List<Imagen> Galeria = [];

      QuerySnapshot categoriaSnapshot = await firestore
          .collection('Articulo')
          .doc(documento.id)
          .collection('categories')
          .get();

      QuerySnapshot galeriaSnapshot = await firestore
          .collection('Articulo')
          .doc(documento.id)
          .collection('gallery')
          .get();

      listaCategorias = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      Galeria = galeriaSnapshot.docs.map((ImagenDoc) {
        return Imagen(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
      }).toList();

      Articulo oneArticulo = Articulo(
        idarticle: documento.id,
        idprof: documento['idprof'],
        date: documento['date'],
        title: documento['title'],
        content: documento['content'],
        categories: listaCategorias,
        gallery: Galeria,
      );

      listaArticulo.add(oneArticulo);
    });

    return listaArticulo;
  }

  //Obtener una lista con todos lo articulos de un profecionista en especifico
  static Future<List<Articulo>> getProfArticulo(String idprof) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore
        .collection('Articulo')
        .where('idprof', isEqualTo: idprof)
        .get();

    List<Articulo> listaArticulo = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      print('Document ID: ${documento.id}');
      print('Document Data: ${documento.data().toString()}');
      List<Categoria> listaCategorias = [];
      List<Imagen> Galeria = [];

      QuerySnapshot categoriaSnapshot = await firestore
          .collection('Articulo')
          .doc(documento.id)
          .collection('categories')
          .get();

      await Future.forEach(categoriaSnapshot.docs, (cat) async {
        print('Document ID: ${cat.id}');
        print('Document Data: ${cat.data().toString()}');

        Categoria onecategoria = Categoria(
          idcategory: cat.id,
          name: cat.get('name'),
          type: cat.get('type'),
        );
        listaCategorias.add(onecategoria);
      });

      QuerySnapshot galeriaSnapshot = await firestore
          .collection('Articulo')
          .doc(documento.id)
          .collection('gallery')
          .get();

      await Future.forEach(galeriaSnapshot.docs, (ImagenDoc) async {
        print('Document ID: ${ImagenDoc.id}');
        print('Document Data: ${ImagenDoc.data().toString()}');

        Imagen oneimagen = Imagen(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
        Galeria.add(oneimagen);
      });

      Articulo oneArticulo = Articulo(
        idarticle: documento.id,
        idprof: documento['idprof'],
        date: documento['date'],
        title: documento['title'],
        content: documento['content'],
        categories: listaCategorias,
        gallery: Galeria,
      );

      listaArticulo.add(oneArticulo);
    });
    return listaArticulo;
  }
}
