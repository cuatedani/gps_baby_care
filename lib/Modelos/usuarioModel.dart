class Usuario {
  String? iduser;
  String name;
  String email;
  String password;
  String phone;
  String address;
  bool? isProf;
  String? picture;

  Usuario({
    this.iduser,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    this.isProf,
    this.picture,
  });

  Map<String, dynamic> Registrar() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': 'SinEspecificar',
      'address': 'SinEspecificar',
      'isProf': false,
      'picture': 'SinFoto',
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'isProf': isProf,
      'picture': picture
    };
  }
}

