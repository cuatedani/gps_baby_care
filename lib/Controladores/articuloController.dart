import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/firestoreController.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';

class ArticuloController {
  //Insertar un articulo en la base de datos
  static Future<Articulo> insertArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();

    try {
      DocumentReference docRef = await DB.collection('Articulo').add(a.toMap());

      // Obtener el ID asignado por Firebase
      String idArticulo = docRef.id;

      // Asignar el ID al objeto Articulo
      a.idarticle = idArticulo;

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

      // Retornar el objeto Articulo con el ID asignado
      return a;
    } catch (e) {
      print("Aparecio el Error: ${e.toString()}");
      return a;
    }
  }

  //Actualizar un articulo en la base de datos
  static Future<void> updateArticulo(Articulo a) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();

    try {
      // Actualizar el documento principal del artículo
      await DB.collection('Articulo').doc(a.idarticle).set(a.toMap());

      // Eliminar documentos viejos de la subcolección 'gallery'
      await DB.collection('Articulo').doc(a.idarticle).collection('gallery').get().then(
            (snapshot) async {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            await doc.reference.delete();
          }
        },
      );

      // Insertar nuevas imágenes en la subcolección 'gallery'
      if (a.gallery!.isNotEmpty) {
        await Future.forEach(a.gallery!, (imagen) async {
          await DB.collection('Articulo').doc(a.idarticle).collection('gallery').add(imagen.toMap());
        });
      }

      // Eliminar documentos viejos de la subcolección 'categories'
      await DB.collection('Articulo').doc(a.idarticle).collection('categories').get().then(
            (snapshot) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );

      // Insertar nuevas categorías en la subcolección 'categories'
      if (a.categories!.isNotEmpty) {
        await Future.forEach(a.categories!, (categoria) async {
          await DB.collection('Articulo').doc(a.idarticle).collection('categories').add(categoria.toMap());
        });
      }
    } catch (e) {
      print("Apareció el error: ${e.toString()}");
      // Puedes manejar el error según tus necesidades
    }
  }

  //Eliminar un articulo de la base de datos
  static Future<void> deleteArticulo(Articulo a) async{
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    try {
      //Eliminar Imagenes
      //await ImagenController.DeleteFolder('article',a.idarticle!);

      // Eliminar el artículo
      await DB.collection('Articulo').doc(a.idarticle).delete();

      // Eliminar documentos viejos de la subcolección 'gallery'
      await DB.collection('Articulo').doc(a.idarticle).collection('gallery').get().then(
            (snapshot) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );

      // Eliminar documentos viejos de la subcolección 'categories'
      await DB.collection('Articulo').doc(a.idarticle).collection('categories').get().then(
            (snapshot) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );

    } catch (e) {
      print("Apareció el Error: ${e.toString()}");
    }
  }

  //Obtener una Lista con Todos los Articulos
  static Future<List<Articulo>> getAllArticulo() async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await firestore.collection('Articulo').get();

    List<Articulo> listaArticulo = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> listaCategorias = [];
      List<ImagenModel> Galeria = [];

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
        return ImagenModel(
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
      List<Categoria> listaCategorias = [];
      List<ImagenModel> Galeria = [];

      QuerySnapshot categoriaSnapshot = await firestore
          .collection('Articulo')
          .doc(documento.id)
          .collection('categories')
          .get();

      await Future.forEach(categoriaSnapshot.docs, (cat) async {

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

        ImagenModel oneimagen = ImagenModel(
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

  //Falta Filtrado para Usuario y Profesional
}
