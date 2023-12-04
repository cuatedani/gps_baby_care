import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticuloPageView.dart';

import '../../Componente/MenuWidget.dart';

class ArticulosView extends StatefulWidget {
  const ArticulosView({super.key});

  @override
  State<ArticulosView> createState() => _ArticulosViewState();
}

class _ArticulosViewState extends State<ArticulosView> {
  late List<Articulo> ListaArticulos = [];

  //Seria necesario solo añadir filtros

  @override
  void initState() {
    super.initState();
    cargarArticulos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Consejos & Cuidados",
            style: TextStyle(fontSize: 23),
          ),
          leading: MenuWidget(),
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Center(child: Text("Filtros"),),
              Divider(),
              Container(
                child: (ListaArticulos.isNotEmpty)
                    ? Text("POR EL MOMENTO NO HAY ARTICULOS QUE MOSTRAR")
                    : ListView.builder(
                        itemCount: ListaArticulos.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ArticuloPageView(
                                    Art: ListaArticulos[index],
                                  ),
                                ),
                              );
                            },
                            child: BannerArticulo(ListaArticulos[index]),
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }

  //Zona de Metodos
  //Cargar Articulos de la Base de datos
  Future<void> cargarArticulos() async {
    List<Articulo> articulos = await ArticuloController.getAllArticulo();
    if (mounted) {
      setState(() {
        ListaArticulos = articulos;
      });
    }
  }
}
