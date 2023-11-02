class Producto {
  String? idproduct;
  String name;
  double price;
  String description;
  String? gallery;
  String quantity;

  Producto({
    this.idproduct,
    required this.name,
    required this.price,
    required this.description,
    this.gallery,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': name,
      'precio': price,
      'descripcion': description,
      'galeria':gallery,
      'cantidad': quantity,
    };
  }

}