import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';

class Producto {
  String? idproduct;
  String name;
  double price;
  String description;
  List<Categoria>? categories;
  List<ImagenModel>? gallery;
  int quantity;

  Producto({
    this.idproduct,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    this.categories,
    this.gallery,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }
}