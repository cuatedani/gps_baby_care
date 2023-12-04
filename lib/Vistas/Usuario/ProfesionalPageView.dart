import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
class ProfesionalPageView extends StatefulWidget {
  final Profesional Proff;
  const ProfesionalPageView({super.key, required this.Proff});

  @override
  State<ProfesionalPageView> createState() => _ProfesionalPageViewState();
}

class _ProfesionalPageViewState extends State<ProfesionalPageView> {
  late Profesional Proff;

  //Este Codigo de mostrar informacion publica del profesional
  //Obtener Usuario, Instituto, Productos, Articulos y poder Hacer cita

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
