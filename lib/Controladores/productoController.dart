import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';

class ProductoController {
  //Inserta un Producto
  static Future<void> insertProducto(Producto producto) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').add(producto.toMap());
  }

  //Actualiza un Producto
  static Future<void> updateProducto(Producto producto) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').doc(producto.idproduct).set(producto.toMap());
  }

  //Elimina Definitivamente un Producto
  static Future<void> deleteProducto(String productId) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').doc(productId).delete();
  }

  //Obtiene todos los Productos
  static Future<List<Producto>> getAllProductos() async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await DB.collection('Productos').get();
    List<Producto> listaProductos = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Producto oneProduct = Producto(
        idproduct: documento.id,
        name: documento['nombre'],
        price: documento['precio'],
        description: documento['descripcion'],
        quantity: documento['cantidad'],
      );

      listaProductos.add(oneProduct);
    });

    return listaProductos;
  }

  //Obtiene un Producto por Id
  static Future<Producto?> getOneProducto(String id) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documento = await DB.collection('Productos').doc(id).get();

    if (documento.exists) {
      return Producto(
        idproduct: documento.id,
        name: documento['nombre'],
        price: documento['precio'],
        description: documento['descripcion'],
        quantity: documento['cantidad'],
      );
    } else {
      return null;
    }
  }
}
