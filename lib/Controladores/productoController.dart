import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';

class ProductoController {
  static Future<void> insertProducto(Producto producto) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').add(producto.Registrar());
  }

  static Future<void> updateProducto(Producto producto) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').doc(producto.idproduct).set(producto.Actualizar());
  }

  static Future<void> deleteProducto(String productId) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    await DB.collection('Productos').doc(productId).delete();
  }

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
        gallery: List<String>.from(documento['galeria'] ?? []),
        category: documento['categoria'], // ¡Recuerda recuperar las categorías si también están almacenadas!
        quantity: documento['cantidad'],
      );

      listaProductos.add(oneProduct);
    });

    return listaProductos;
  }

  static Future<Producto?> getOneProducto(String productId) async {
    FirebaseFirestore DB = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documento = await DB.collection('Productos').doc(productId).get();

    if (documento.exists) {
      return Producto(
        idproduct: documento.id,
        name: documento['nombre'],
        price: documento['precio'],
        description: documento['descripcion'],
        gallery: List<String>.from(documento['galeria'] ?? []),
        category: documento['categoria'], // ¡Recuerda recuperar las categorías si también están almacenadas!
        quantity: documento['cantidad'],
      );
    } else {
      return null; // El producto no existe
    }
  }
}
