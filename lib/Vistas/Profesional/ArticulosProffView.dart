import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class ArticulosProffView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;
  const ArticulosProffView({Key? key, required this.Proff, required this.User}) : super(key: key);

  @override
  State<ArticulosProffView> createState() => _ArticulosProffViewState();
}

class _ArticulosProffViewState extends State<ArticulosProffView> {
  late Profesional Proff;
  late Usuario User;

  @override
  void initState() {
    super.initState();
    Proff = widget.Proff;
    User = widget.User;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
