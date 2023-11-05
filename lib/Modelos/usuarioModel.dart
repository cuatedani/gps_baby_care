import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? iduser;
  String name;
  String lastname;
  String email;
  String password;
  String? phone;
  GeoPoint? address;
  bool? isProf;
  bool? isAdmin;
  String? picture;

  Usuario({
    this.iduser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.isProf,
    this.isAdmin,
    this.picture,
  });

  Map<String, dynamic> Registrar() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone': 'SinEspecificar',
      'address': 'SinEspecificar',
      'isProf': false,
      'isAdmin': false,
      'picture': 'SinRecurso',
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'isProf': isProf,
      'isAdmin': isAdmin,
      'picture': picture
    };
  }

  //Metodo Pendiente
  String getAddress() {
    return 'Direccion obtenida desde geopoint';
  }
}

