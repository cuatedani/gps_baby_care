import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';

class ArticuloPageProff extends StatefulWidget {
  final Articulo  art;
  final Profesional proff;
  const ArticuloPageProff({super.key, required this.art, required this.proff});

  @override
  State<ArticuloPageProff> createState() => _ArticuloPageProffState();
}

class _ArticuloPageProffState extends State<ArticuloPageProff> {
  late Articulo Art;
  late Profesional Proff;
  late List<Categoria> categorieslist = [];

  @override
  void initState() {
    Proff = widget.proff;
    Art = widget.art;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

  //Zona de Metodos
  //Metodo para cargar datos
  Future<void> cargardatos() async {
    List<Categoria> temporal = await CategoriaController.getArticuloCategoria();
    if (mounted) {
      setState(() {
        categorieslist = temporal;
      });
    }
  }
}
