class Profesional {
  String idprof;
  String iduser;
  String idinstitute;
  String occupation;

  Profesional({
    required this.idprof,
    required this.iduser,
    required this.idinstitute,
    required this.occupation,
  });

  Map<String, dynamic> Registrar() {
    return {
      'iduser': iduser,
      'idinstitute': idinstitute,
      'occupation': occupation,
    };
  }

  Map<String, dynamic> Actualizar() {
    return {
      'idprof': idprof,
      'iduser': iduser,
      'idinstitute': idinstitute,
      'occupation': occupation,
    };
  }

}