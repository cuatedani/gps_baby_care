import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';

class ProductoController {
  //Inserta un Producto
  static Future<Producto> insertProducto(Producto p) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    print("hola");

    try {
      DocumentReference docRef =
          await DB.collection('Productos').add(p.toMap());

      // Asignar el ID al objeto Articulo
      p.idproduct = docRef.id;
      print("hola tiene id");

      if (p.categories!.isNotEmpty) {
        // Insertar categorías en la subcolección 'categories'
        await Future.forEach(p.categories!, (categoria) async {
          await docRef.collection('categories').add(categoria.toMap());
        });
      }

      // Retornar el objeto Articulo con el ID asignado
      print("hola retorna");
      return p;
    } catch (e) {
      print("Aparecio el Error: ${e.toString()}");
      return p;
    }
  }

  //Actualizar un Producto en la base de datos
  static Future<void> updateProducto(Producto p) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').doc(p.idproduct).set(p.toMap());

    try {
      // Actualizar el documento principal del artículo
      await DB.collection('Productos').doc(p.idproduct).set(p.toMap());

      // Eliminar documentos viejos de la subcolección 'gallery'
      await DB
          .collection('Productos')
          .doc(p.idproduct)
          .collection('gallery')
          .get()
          .then(
        (snapshot) async {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            await doc.reference.delete();
          }
        },
      );

      // Insertar nuevas imágenes en la subcolección 'gallery'
      if (p.gallery!.isNotEmpty) {
        await Future.forEach(p.gallery!, (imagen) async {
          await DB
              .collection('Productos')
              .doc(p.idproduct)
              .collection('gallery')
              .add(imagen.toMap());
        });
      }

      // Eliminar documentos viejos de la subcolección 'categories'
      await DB
          .collection('Productos')
          .doc(p.idproduct)
          .collection('categories')
          .get()
          .then(
        (snapshot) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );

      // Insertar nuevas categorías en la subcolección 'categories'
      if (p.categories!.isNotEmpty) {
        await Future.forEach(p.categories!, (categoria) async {
          await DB
              .collection('Productos')
              .doc(p.idproduct)
              .collection('categories')
              .add(categoria.toMap());
        });
      }
    } catch (e) {
      print("Apareció el error: ${e.toString()}");
      // Puedes manejar el error según tus necesidades
    }
  }

  //Elimina Definitivamente un Producto
  static Future<void> deleteProducto(String id) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    try {
      //Eliminar Imagenes
      //await ImagenController.DeleteFolder('article',a.idarticle!);

      // Eliminar el Producto
      await DB.collection('Productos').doc(id).delete();

      // Eliminar documentos de la subcolección 'gallery'
      await DB.collection('Productos').doc(id).collection('gallery').get().then(
        (snapshot) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );

      // Eliminar documentos de la subcolección 'categories'
      await DB
          .collection('Productos')
          .doc(id)
          .collection('categories')
          .get()
          .then(
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

  //Obtiene todos los Productos
  static Future<List<Producto>> getAllProductos() async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await DB.collection('Productos').get();
    List<Producto> products = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> categories = [];
      List<ImagenModel> gallery = [];

      QuerySnapshot categoriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('categories')
          .where('quantity', isGreaterThan: 0)
          .get();

      QuerySnapshot galeriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('gallery')
          .get();

      categories = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      gallery = galeriaSnapshot.docs.map((ImagenDoc) {
        return ImagenModel(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
      }).toList();

      Producto oneProduct = Producto(
        idproduct: documento.id,
        iduser: documento['iduser'],
        name: documento['name'],
        price: documento['price'],
        description: documento['description'],
        quantity: documento['quantity'],
        categories: categories,
        gallery: gallery,
      );

      products.add(oneProduct);
    });

    return products;
  }

  //Obtiene todos los Productos
  static Future<List<Producto>> filtrarAllProductos(String text) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await DB.collection('Productos').get();
    List<Producto> products = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> categories = [];
      List<ImagenModel> gallery = [];

      QuerySnapshot categoriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('categories')
          .where('quantity', isGreaterThan: 0)
          .get();

      QuerySnapshot galeriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('gallery')
          .get();

      categories = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      gallery = galeriaSnapshot.docs.map((ImagenDoc) {
        return ImagenModel(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
      }).toList();

      Producto oneProduct = Producto(
        idproduct: documento.id,
        iduser: documento['iduser'],
        name: documento['name'],
        price: documento['price'],
        description: documento['description'],
        quantity: documento['quantity'],
        categories: categories,
        gallery: gallery,
      );

      if(oneProduct.name.contains(text) || oneProduct.description.contains(text)){
        products.add(oneProduct);
      }
    });

    return products;
  }

  //Obtiene todos los Productos de un Usuario
  static Future<List<Producto>> getAllUserProductos(String userid) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await DB
        .collection('Productos')
        .where("iduser", isEqualTo: userid)
        .get();
    List<Producto> products = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      List<Categoria> categories = [];
      List<ImagenModel> gallery = [];

      QuerySnapshot categoriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('categories')
          .get();

      QuerySnapshot galeriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('gallery')
          .get();

      categories = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      gallery = galeriaSnapshot.docs.map((ImagenDoc) {
        return ImagenModel(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
      }).toList();

      Producto oneProduct = Producto(
        idproduct: documento.id,
        iduser: documento['iduser'],
        name: documento['name'],
        price: documento['price'],
        description: documento['description'],
        quantity: documento['quantity'],
        categories: categories,
        gallery: gallery,
      );

      products.add(oneProduct);
    });

    return products;
  }

  //Obtiene un Producto por Id
  static Future<Producto?> getOneProducto(String id) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documento =
        await DB.collection('Productos').doc(id).get();

    if (documento.exists) {
      List<Categoria> categories = [];
      List<ImagenModel> gallery = [];

      QuerySnapshot categoriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('categories')
          .get();

      QuerySnapshot galeriaSnapshot = await DB
          .collection('Productos')
          .doc(documento.id)
          .collection('gallery')
          .get();

      categories = categoriaSnapshot.docs.map((categoriaDoc) {
        return Categoria(
          idcategory: categoriaDoc.id,
          name: categoriaDoc.get('name'),
          type: categoriaDoc.get('type'),
        );
      }).toList();

      gallery = galeriaSnapshot.docs.map((ImagenDoc) {
        return ImagenModel(
          idimagen: ImagenDoc.id,
          name: ImagenDoc.get('name'),
          url: ImagenDoc.get('url'),
        );
      }).toList();

      return Producto(
        idproduct: documento.id,
        iduser: documento['iduser'],
        name: documento['name'],
        price: documento['price'],
        description: documento['description'],
        quantity: documento['quantity'],
        categories: categories,
        gallery: gallery,
      );
    } else {
      return null;
    }
  }
}
