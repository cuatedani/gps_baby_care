import 'package:gps_baby_care/Modelos/imagenModel.dart';

class Usuario {
  String iduser;
  String name;
  String lastname;
  String email;
  String password;
  String phone;
  String address;
  String role;
  ImagenModel picture;
  bool isdeleted;

  Usuario({
    required this.iduser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.role,
    required this.picture,
    required this.isdeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'role': role,
      'picture': picture.toMap(),
      'isdeleted': isdeleted,
    };
  }
}

