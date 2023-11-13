import 'package:cloud_firestore/cloud_firestore.dart';

class Articulo {
  String? idarticle;
  String idprof;
  Timestamp date;
  String title;
  String content;
  List<String>? categories;
  List<String>? gallery;

  Articulo({
    this.idarticle,
    required this.idprof,
    required this.date,
    required this.title,
    required this.content,
    this.categories,
    this.gallery,
  });

  Map<String, dynamic> Registrar() {
    return {
      'idprof': idprof,
      'date': date,
      'title': title,
      'content': content,
      'category': categories,
      'gallery': gallery,
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'idarticle': idarticle,
      'idprof': idprof,
      'date': date,
      'title': title,
      'content': content,
      'category': categories,
      'gallery': gallery,
    };
  }
}