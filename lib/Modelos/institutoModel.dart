class Instituto {
  String? idinstituto;
  String nombre;
  String telefono;
  String direccion;
  String descripcion;
  String? logo;

  Instituto({
    this.idinstituto,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.descripcion,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
      'descripcion': descripcion,
    };
  }
  
}