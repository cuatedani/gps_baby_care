import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
class ProffPageAdminView extends StatefulWidget {
  final Profesional Proff;
  const ProffPageAdminView({super.key, required this.Proff});

  @override
  State<ProffPageAdminView> createState() => _ProffPageAdminViewState();
}

class _ProffPageAdminViewState extends State<ProffPageAdminView> {
  late Profesional Proff;
  late Instituto Inst;
  late Usuario User;
  List<Articulo> articulosList = [];

  @override
  void initState() {
    Proff = widget.Proff;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: (User.picture.url != 'SinUrl')
                  ? NetworkImage(User.picture.url) as ImageProvider<Object>
                  : AssetImage("assets/images/defaultlogo.png")
              as ImageProvider<Object>,
            ),
            Text("${User.name} ${User.lastname}"),
            Text("${Proff.occupation}"),
            Divider(),
            Text("${Inst.name}"),
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Cargar datos de la BD
  Future<void> cargardatos() async {
    Usuario tempUser = await UsuarioController.getProffUsuario(Proff);
    Instituto tempInst = await InstitutoController.getOneInstituto(Proff.idinstitute);
    Profesional tempProff = await ProfesionalController.getOneProfesional(Proff.idprof);
    List<Articulo> tempArt = await ArticuloController.getProfArticulo(tempProff);
    if (mounted) {
      setState(() {
        Proff = tempProff;
        User = tempUser;
        Inst = tempInst;
        articulosList = tempArt;
      });
    }
  }
}
