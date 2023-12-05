class Cita {
  String idCita;
  String idProfesional;
  String idUsuario;
  DateTime fecha;
  String motivo;

  Cita({
    required this.idCita,
    required this.idProfesional,
    required this.idUsuario,
    required this.fecha,
    required this.motivo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCita': idCita,
      'idProfesional': idProfesional,
      'idUsuario': idUsuario,
      'fecha': fecha.toIso8601String(), // Convertir la fecha a un formato de texto
      'motivo': motivo,
    };
  }

  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      idCita: map['idCita'],
      idProfesional: map['idProfesional'],
      idUsuario: map['idUsuario'],
      fecha: DateTime.parse(map['fecha']), // Convertir el texto de la fecha a DateTime
      motivo: map['motivo'],
    );
  }
}
