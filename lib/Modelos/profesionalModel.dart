class Profesional {
  String? idprof;
  String iduser;
  String idinstitute;
  String occupation;
  String degree;

  Profesional({
    this.idprof,
    required this.iduser,
    required this.idinstitute,
    required this.occupation,
    required this.degree,
  });

  Map<String, dynamic> toMap() {
    return {
      'iduser': iduser,
      'idinstitute': idinstitute,
      'occupation': occupation,
      'degree':degree,
    };
  }

}