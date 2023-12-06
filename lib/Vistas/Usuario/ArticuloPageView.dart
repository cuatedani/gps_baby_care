import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Componente/GaleriaWidget.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/InstitutoPageView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalPageView.dart';

class ArticuloPageView extends StatefulWidget {
  final Articulo Art;
  final Profesional Proff;
  final Usuario User;
  final Instituto Inst;
  const ArticuloPageView(
      {super.key,
      required this.Art,
      required this.Proff,
      required this.User,
      required this.Inst});

  @override
  State<ArticuloPageView> createState() => _ArticuloPageViewState();
}

//Solo Necesita un poco de diseño

class _ArticuloPageViewState extends State<ArticuloPageView> {
  late Articulo Art;
  late Usuario User;
  late Instituto Inst;
  late Profesional Proff;
  List<Categoria> categories = [];
  List<ImagenModel> gallery = [];

  @override
  void initState() {
    Art = widget.Art;
    categories = Art.categories!;
    gallery = Art.gallery!;
    User = widget.User;
    Inst = widget.Inst;
    Proff = widget.Proff;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(title: const Text("Articulo")),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "${Art.title}",
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProfesionalPageView(
                          Proff: Proff,
                          User: User,
                          Inst: Inst,
                        ),
                      ),
                    );
                  },
                  child: Text("${User.name} ${User.lastname}", style: TextStyle(fontWeight: FontWeight.w600, color:Color(0XFF7D8B5F)), ),
                ),
                Text("${Art.getDate()}"),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                Proff.occupation,
              ),
            ),
            SizedBox(height: 30,),
            Text(Art.content, textAlign: TextAlign.justify ,style: TextStyle(fontSize: 17),),
            SizedBox(height: 30,),
            if (Art.gallery!.isNotEmpty) GaleriaWidget(imagenes: Art.gallery),
            SizedBox(height: 30,),
            (categories.isNotEmpty)
                ? CategoriasWidget(categories)
                : const Text("Sin Categorias Asignadas"),
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
          ],
        ),
      ),
    ),
    );
  }

  //Zona de Metodos
  //Cargar Articulos de la Base de datos
  Future<void> cargardatos() async {
    Articulo tempArt = await ArticuloController.getOneArticulo(Art.idprof);

    Profesional? tempProff =
        await ProfesionalController.getOneProfesional(Proff.idprof);

    Usuario tempUser = await UsuarioController.getOneUsuario(tempProff!.iduser);

    Instituto? tempInst =
        await InstitutoController.getOneInstituto(tempProff.idinstitute);

    if (mounted) {
      setState(() {
        Art = tempArt;
        categories = Art.categories!;
        gallery = Art.gallery!;
        User = tempUser;
        Proff = tempProff;
        Inst = tempInst!;
      });
    }
  }
}
