import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';

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
  late List<Articulo> ListaArticulos = [];

  @override
  void initState() {
    super.initState();
    Proff = widget.Proff;
    User = widget.User;
    cargarArticulos();
  }

  Future<void> cargarArticulos() async {
    ListaArticulos = await ArticuloController.getProfArticulo(Proff.idprof);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/img_4.png"),
          if (ListaArticulos != null && ListaArticulos.isNotEmpty)
            ...ListaArticulos.map((articulo) => BannerArticulo(articulo)).toList()
          else
            Padding(
              padding: const EdgeInsets.all(16.0),

              child: Text("No tiene artículos creados"),
            ),
        ],
      ),
    );
  }
}

