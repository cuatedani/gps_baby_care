class Categoria {
  String idcategory;
  String name;
  String type;

  Categoria({
    required this.idcategory,
    required this.name,
    required this.type
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type
    };
  }
}
