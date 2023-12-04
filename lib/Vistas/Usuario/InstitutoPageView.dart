import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';

class InstitutoPageView extends StatefulWidget {
  final Instituto Inst;
  const InstitutoPageView({super.key, required this.Inst});

  @override
  State<InstitutoPageView> createState() => _InstitutoPageViewState();
}

class _InstitutoPageViewState extends State<InstitutoPageView> {
  late Instituto Inst;

  //Aqui debe mostarse toda la info publica de un Instituto, ademas de sus Profesionistas
  //al hacer click en un profesionista redirigir a ProfesionalPageView

  @override
  void initState() {
    Inst = widget.Inst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
