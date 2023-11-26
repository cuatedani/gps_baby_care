import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Vistas/Profesional/AddArticuloView.dart';

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
        await ArticuloController.getProfArticulo(Proff.idprof);
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
      body: ListView.separated(
        itemCount: ListaArticulos.length + 1,
        separatorBuilder: (context, index) =>
            Divider(),
        itemBuilder: (context, index) {
          if (index == ListaArticulos.length) {
            return Center(child: Text(texto));
          } else {
            return InkWell(
              onTap: () {
                print("Pendiente Interfaz ArticuloView(User) y EditArticuloView(Proff)");
              },
              child: BannerArticulo(ListaArticulos[index]),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
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
