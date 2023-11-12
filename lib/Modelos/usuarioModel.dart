import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Usuario {
  String iduser;
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
    required this.iduser,
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
      'address': null,
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

  Future<String?> getAddressFromGeoPoint(GeoPoint? geoPoint) async {
    if (geoPoint == null) {
      return null;
    }

    final apiKey = 'TU_API_KEY'; // Reemplaza con tu clave de API de Google Maps

    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${geoPoint.latitude},${geoPoint.longitude}&key=$apiKey'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final results = decodedResponse['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final formattedAddress = results[0]['formatted_address'] as String;
        return formattedAddress;
      }
    }

    return null;
  }
}

