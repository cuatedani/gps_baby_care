import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';

class Articulo {
  String? idarticle;
  String idprof;
  Timestamp date;
  String title;
  String content;
  List<Categoria>? categories;
  List<ImagenModel>? gallery;

  Articulo({
    this.idarticle,
    required this.idprof,
    required this.date,
    required this.title,
    required this.content,
    this.categories,
    this.gallery,
  });

  Map<String, dynamic> toMap() {
    return {
      'idprof': idprof,
      'date': date,
      'title': title,
      'content': content,
    };
  }

  DateTime getDate() {
    return DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
  }
}
