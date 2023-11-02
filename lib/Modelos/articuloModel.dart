import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class Articulo {
  String? idarticle;
  String idprof;
  DateTime date;
  String title;
  String content;
  List<Categoria> category;
  List<String>? gallery;

  Articulo({
    this.idarticle,
    required this.idprof,
    required this.date,
    required this.title,
    required this.content,
    required this.category,
    this.gallery,
  });

  Map<String, dynamic> Registrar() {
    return {
      'idprof': idprof,
      'date': date,
      'title': title,
      'content': content,
      'category': category,
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
      'category': category,
      'gallery': gallery,
    };
  }

}