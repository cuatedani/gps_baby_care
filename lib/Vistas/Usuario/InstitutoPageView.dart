import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalPageView.dart';

class InstitutoPageView extends StatefulWidget {
  final Instituto Inst;
  const InstitutoPageView({super.key, required this.Inst});

  @override
  State<InstitutoPageView> createState() => _InstitutoPageViewState();
}

class _InstitutoPageViewState extends State<InstitutoPageView> {
  //Aqui debe mostarse toda la info publica de un Instituto, ademas de sus Profesionistas
  //al hacer click en un profesionista redirigir a ProfesionalPageView
  late Instituto Inst;
  List<Profesional> proffList = [];
  List<Usuario> userList = [];

  @override
  void initState() {
    Inst = widget.Inst;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: const Text("Institutos"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: (Inst.logo.url != 'SinUrl')
                  ? NetworkImage(Inst.logo.url) as ImageProvider<Object>
                  : AssetImage("assets/images/defaultlogo.png")
                      as ImageProvider<Object>,
            ),
            Text("${Inst.name}"),
            Divider(),
            Text("Telefono: ${Inst.phone}"),
            Text("Direccion: ${Inst.address}"),
            Divider(),
            Text("${Inst.description}"),
            Divider(),
            Expanded(
              child: (proffList.isEmpty)
                  ? Text("No hay Profesionistas registrados")
                  : ListView.builder(
                      itemCount: proffList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navegar a la página ProfesionalPageView
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfesionalPageView(
                                  Proff: proffList[index],
                                  User: userList[index],
                                  Inst: Inst,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: (userList[index].picture.url !=
                                      'SinUrl')
                                  ? NetworkImage(userList[index].picture.url)
                                      as ImageProvider<Object>
                                  : AssetImage("assets/images/perfil.png")
                                      as ImageProvider<Object>,
                            ),
                            title: Text(userList[index].name),
                            subtitle: Text(proffList[index].occupation),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Profesional> tempproffList =
        await ProfesionalController.getInstProfesional(Inst);

    List<Usuario> tempuserList = [];
    await Future.forEach(
        tempproffList,
        (proff) async =>
            tempuserList.add(await UsuarioController.getOneUsuario(proff.iduser)));

    if (mounted) {
      setState(() {
        proffList = tempproffList;
        userList = tempuserList;
      });
    }
  }
}
