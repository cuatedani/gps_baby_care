class Articulo {
  String? idarticle;
  String idprof;
  DateTime date;
  String title;
  String category;
  String gallery;

  Articulo({
    this.idarticle,
    required this.idprof,
    required this.date,
    required this.title,
    required this.category,
    required this.gallery,
  });

  Map<String, dynamic> toMap() {
    return {
      'idprof': idprof,
      'date': date,
      'title': title,
      'category': category,
      'gallery': gallery,
    };
  }

}