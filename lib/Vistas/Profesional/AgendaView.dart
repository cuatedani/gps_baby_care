import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';

class AgendaView extends StatefulWidget {
  final Profesional Proff;
  const AgendaView({super.key, required this.Proff});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

//Falta Hacer Modelo y Controller para las Citas
//Aqui apareceran las citas del Profesional,
//Tendra filtro por estado(Pendientes, Finalizadas, Canceladas) y texto
//Redirige a CitaPageProffView permite modificar citas

class _AgendaViewState extends State<AgendaView> {
  late Profesional Proff;

  @override
  void initState() {
    Proff = widget.Proff;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
