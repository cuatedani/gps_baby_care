import 'package:gps_baby_care/Modelos/imagenModel.dart';

class Instituto {
  String idinstitute;
  String name;
  String phone;
  String address;
  String description;
  ImagenModel logo;
  bool isdeleted;

  Instituto({
    required this.idinstitute,
    required this.name,
    required this.phone,
    required this.address,
    required this.description,
    required this.logo,
    required this.isdeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'description': description,
      'logo': logo.toMap(),
      'isdeleted': isdeleted,
    };
  }
}