class Profesional {
  String idprof;
  String iduser;
  String idinstitute;
  String occupation;
  bool isdeleted;

  Profesional({
    required this.idprof,
    required this.iduser,
    required this.idinstitute,
    required this.occupation,
    required this.isdeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'iduser': iduser,
      'idinstitute': idinstitute,
      'occupation': occupation,
      'isdeleted': isdeleted,
    };
  }
}