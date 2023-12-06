import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Componente/ProductsWidget.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticuloPageView.dart';
import 'package:gps_baby_care/Vistas/Usuario/InstitutoPageView.dart';
import 'package:gps_baby_care/Vistas/Usuario/FormularioCita.dart';

class ProfesionalPageView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;
  final Instituto Inst;
  const ProfesionalPageView(
      {super.key, required this.Proff, required this.User, required this.Inst});

  @override
  State<ProfesionalPageView> createState() => _ProfesionalPageViewState();
}

class _ProfesionalPageViewState extends State<ProfesionalPageView> {
  late Profesional Proff;
  late Usuario User;
  late Instituto Inst;
  List<Producto> products = [];
  List<Articulo> articles = [];

  //Este Codigo de mostrar informacion publica del profesional
  //Obtener Usuario, Instituto, Productos, Articulos y poder Hacer cita

  @override
  void initState() {
    Proff = widget.Proff;
    User = widget.User;
    Inst = widget.Inst;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profesional"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: (User.picture.url != 'SinUrl')
                  ? NetworkImage(User.picture.url) as ImageProvider<Object>
                  : AssetImage("assets/images/perfil.png")
                      as ImageProvider<Object>,
            ),
            Text("${User.name} ${User.lastname}"),
            Text("Ocupacion: ${Proff.occupation}"),
            Divider(),
            Center(
              child: ElevatedButton(
                child: const Text("Agendar una Cita"),
                onPressed: () {
                  String idUsuario = User.iduser; // Obtener el idUsuario del parámetro User
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormularioCita(
                        idProfesional: Proff.idprof,
                        idUsuario: idUsuario,
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            InkWell(
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (Inst.logo.url != 'SinUrl')
                        ? NetworkImage(Inst.logo.url) as ImageProvider<Object>
                        : AssetImage("assets/images/defaultlogo.png")
                            as ImageProvider<Object>,
                  ),
                  title: Text("${Inst.name}"),
                  subtitle: Inst.description.length < 40
                      ? Text(
                          '${Inst.description}',
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          '${Inst.description.substring(0, 40)} ...',
                          style: TextStyle(fontSize: 15),
                        )),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => InstitutoPageView(
                      Inst: Inst,
                    ),
                  ),
                );
              },
            ),
            Divider(),
            const Text("Productos: "),
            (products.isEmpty)
                ? Text("No cuenta con productos a la venta")
                : ProductsWidget(context, products),
            Divider(),
            const Text("Articulos: "),
            Expanded(
              child: (articles.isEmpty)
                  ? Text("No hay Articulos Publicados")
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            Profesional? tempProff =
                                await ProfesionalController.getOneProfesional(
                                    articles[index].idprof);
                            Instituto? tempInst =
                                await InstitutoController.getOneInstituto(
                                    tempProff.idinstitute);
                            Usuario tempUser =
                                await UsuarioController.getOneUsuario(
                                    tempProff.iduser);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ArticuloPageView(
                                        Art: articles[index],
                                        Proff: tempProff,
                                        User: tempUser,
                                        Inst: tempInst!),
                              ),
                            );
                          },
                          child: BannerArticulo(articles[index]),
                        );
                      },
                    ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Cargar Articulos de la Base de datos
  Future<void> cargardatos() async {
    List<Producto> tempproducts =
        await ProductoController.getAllUserProductos(Proff.iduser);
    List<Articulo> temparticles =
        await ArticuloController.getProfArticulo(Proff);

    if (mounted) {
      setState(() {
        products = tempproducts;
        articles = temparticles;
      });
    }
  }
}
