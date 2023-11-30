//import 'package:gps_baby_care/Modelos/categoriaModel.dart';
class Producto {
  String? idproduct;
  String name;
  double price;
  String description;
  List<String>? gallery;
  String category;
  int quantity;

  Producto({
    this.idproduct,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.gallery,
    required this.quantity,
  });

  Map<String, dynamic> Registrar() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'galery':gallery,
      'category':category,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'idproduct': idproduct,
      'nombre': name,
      'precio': price,
      'descripcion': description,
      'galeria':gallery,
      'cantidad': quantity,
    };
  }
}