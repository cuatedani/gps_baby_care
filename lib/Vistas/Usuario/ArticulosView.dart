import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
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
    cargarArticulos();
    super.initState();
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF9F3E5),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  'Todos los articulos presentados han sido revisados y certificados por profesionales.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text("Filtros"),
              ),
              Divider(),
              Expanded(
                child: (ListaArticulos.isEmpty)
                    ? Text("POR EL MOMENTO NO HAY ARTICULOS QUE MOSTRAR")
                    : ListView.builder(
                        itemCount: ListaArticulos.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              Profesional? tempProff =
                                  await ProfesionalController.getOneProfesional(
                                      ListaArticulos[index].idprof);
                              if (tempProff != null) {
                                // Hacer algo con el profesional encontrado
                                print("Profesional encontrado: ${tempProff.idprof}");
                              } else {
                                // Manejar el caso en que no se encontró ningún profesional
                                print("No se encontró ningún Profesional con el ID proporcionado.");
                              }

                              Instituto? tempInst =
                                  await InstitutoController.getOneInstituto(
                                      tempProff!.idinstitute);

                              if (tempInst != null) {
                                // Hacer algo con el profesional encontrado
                                print("Insituto encontrado: ${tempInst.idinstitute}");
                              } else {
                                // Manejar el caso en que no se encontró ningún profesional
                                print("No se encontró ningún Insituto con el ID proporcionado.");
                              }

                              Usuario tempUser =
                                  await UsuarioController.getOneUsuario(
                                      tempProff.iduser);

                              if (tempInst != null) {
                                // Hacer algo con el profesional encontrado
                                print("Usuario encontrado: ${tempUser.iduser}");
                              } else {
                                // Manejar el caso en que no se encontró ningún profesional
                                print("No se encontró ningún Usuario con el ID proporcionado.");
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ArticuloPageView(
                                          Art: ListaArticulos[index],
                                          Proff: tempProff,
                                          User: tempUser,
                                          Inst: tempInst!),
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
