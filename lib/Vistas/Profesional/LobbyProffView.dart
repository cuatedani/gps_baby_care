import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

import '../../Componente/MenuWidget.dart';

class LobbyProffView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;
  const LobbyProffView({Key? key, required this.Proff, required this.User})
      : super(key: key);

  @override
  State<LobbyProffView> createState() => _LobbyProffViewState();
}

class _LobbyProffViewState extends State<LobbyProffView> {
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
        backgroundColor: Color(0xFFFAF2E7),
    appBar: AppBar(
    title: const Text("Institutos"),
      leading: MenuWidget(),
    ),
      body: Container(
      padding: EdgeInsets.all(1),
      child: Column(
        children: [
          Text("Este es un lobby para Profesionistas"),
          // Agrega más widgets aquí
        ],
      ),
    ),
    );
  }
}
