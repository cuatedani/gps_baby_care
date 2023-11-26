import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';

class ArticulosView extends StatefulWidget {
  const ArticulosView({super.key});

  @override
  State<ArticulosView> createState() => _ArticulosViewState();
}

class _ArticulosViewState extends State<ArticulosView> {
  late List<Articulo> ListaArticulos = [];
  var info = "";

  @override
  void initState() {
    super.initState();
    cargarArticulos();
  }

  Future<void> cargarArticulos() async {
    List<Articulo> articulos = await ArticuloController.getAllArticulo();
    if (mounted) {
      setState(() {
        if (articulos.length == 0) {
          info = "No hay articulos que mostrar";
        }
        ListaArticulos = articulos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(1),
        constraints: BoxConstraints.expand(),
        child: ListView.separated(
          itemCount: ListaArticulos.length + 1,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            if (index == ListaArticulos.length) {
              return Center(child: Text(info));
            } else {
              return InkWell(
                onTap: () {
                  print("Abriendo Pagina Individual Articulo");
                },
                child: BannerArticulo(ListaArticulos[index]),
              );
            }
          },
        ),
      );
  }
}
