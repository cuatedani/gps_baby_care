import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class EditarPerfilProffView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;
  const EditarPerfilProffView({Key? key, required this.Proff, required this.User}) : super(key: key);

  @override
  State<EditarPerfilProffView> createState() => _EditarPerfilProffViewState();
}

class _EditarPerfilProffViewState extends State<EditarPerfilProffView> {
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
    return Scaffold(
      body: Center(
        child: Text("Este es un perfil para Profesionistas"),
      ),
    );
  }
}
