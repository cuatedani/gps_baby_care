import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class MisCitasView extends StatefulWidget {
  final Usuario User;
  const MisCitasView({super.key, required this.User});

  @override
  State<MisCitasView> createState() => _MisCitasViewState();
}

//Falta Hacer Modelo y Controller para las Citas
//Aqui apareceran las citas del Usuario,
//Tendra filtro por estado(Proximas, Anteriores) y texto
//Redirige a CitaPageView muestra info de la Cita, del Paciente
//, Profesional, Istituto, Y rediroge a sus Paginas

class _MisCitasViewState extends State<MisCitasView> {
  late Usuario User;

  @override
  void initState() {
    User = widget.User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
