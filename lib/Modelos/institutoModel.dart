class Instituto {
  String? idinstitute;
  String name;
  String phone;
  String address;
  String description;
  String? logo;

  Instituto({
    this.idinstitute,
    required this.name,
    required this.phone,
    required this.address,
    required this.description,
    this.logo,
  });

  Map<String, dynamic> Registrar() {
    return {
      'name': name,
      'phone': 'SinEspecificar',
      'address': 'SinEspecificar',
      'description': 'SinEspecificar',
      'logo': 'SinRecurso'
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'description': description,
      'logo': logo
    };
  }
}