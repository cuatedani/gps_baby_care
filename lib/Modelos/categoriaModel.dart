class Categoria {
  String idcategory;
  String name;
  String type;

  Categoria({
    required this.idcategory,
    required this.name,
    required this.type
  });

  Map<String, dynamic> Registrar() {
    return {
      'name': name,
      'type': type
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'idcategory': idcategory,
      'name': name,
      'type': type
    };
  }
}
