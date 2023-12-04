import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Vistas/Profesional/AddArticuloView.dart';
import 'package:gps_baby_care/Vistas/Profesional/ArticuloPageProffView.dart';

class ArticulosProffView extends StatefulWidget {
  final Profesional Proff;
  const ArticulosProffView({Key? key, required this.Proff}) : super(key: key);

  @override
  State<ArticulosProffView> createState() => _ArticulosProffViewState();
}

class _ArticulosProffViewState extends State<ArticulosProffView> {
  late Profesional Proff;
  late List<Articulo> ListaArticulos = [];
  var texto = "";

  @override
  void initState() {
    Proff = widget.Proff;
    super.initState();
    cargarArticulos();
  }

  Future<void> cargarArticulos() async {
    List<Articulo> articulos =
        await ArticuloController.getProfArticulo(Proff);
    if (mounted) {
      setState(() {
        if (articulos.length == 0) {
          texto = "No hay articulos que mostar";
        }
        ListaArticulos = articulos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          itemCount: ListaArticulos.length + 1,
          separatorBuilder: (context, index) =>
              Divider(),
          itemBuilder: (context, index) {
            if (index == ListaArticulos.length) {
              return Center(child: Text(texto));
            } else {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ArticuloPageProff(proff: Proff, art: ListaArticulos[index],),
                    ),
                  );
                },
                child: BannerArticulo(ListaArticulos[index]),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => AddArticuloView(proff: Proff),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
