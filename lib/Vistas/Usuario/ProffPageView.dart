import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
class ProffPageView extends StatefulWidget {
  final Profesional Proff;
  const ProffPageView({super.key, required this.Proff});

  @override
  State<ProffPageView> createState() => _ProffPageViewState();
}

class _ProffPageViewState extends State<ProffPageView> {
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
    return const Placeholder();
  }

  //Zona de Metodos
  //Cargar datos de la BD
  Future<void> cargardatos() async {
    Usuario tempUser = await UsuarioController.getProffUsuario(Proff);
    Instituto tempInst = await InstitutoController.getOneProfInstituto(Proff);
    Profesional tempProff = await ProfesionalController.getOneProfesional(tempUser);
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
