import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Administrador/AddInstProffView.dart';
import 'package:gps_baby_care/Vistas/Administrador/ProffPageAdminView.dart';

class InstitutoPageAdminView extends StatefulWidget {
  final Instituto Ins;
  const InstitutoPageAdminView({super.key, required this.Ins});

  @override
  State<InstitutoPageAdminView> createState() => _InstitutoPageAdminViewState();
}

class _InstitutoPageAdminViewState extends State<InstitutoPageAdminView> {
  late Instituto Inst;
  List<Profesional> proffList = [];
  List<Usuario> userList = [];

  @override
  void initState() {
    Inst = widget.Ins;
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
            Text("${Inst.description}"),
            Text("Telefono: ${Inst.phone}"),
            Text("Direccion: ${Inst.address}"),
            Divider(),
            Expanded(
              child: (proffList.isEmpty)
                  ? Text("No hay Profesionistas registrados")
                  : ListView.builder(
                      itemCount: proffList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navegar a la página ProffPageView
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProffPageAdminView(Proff: proffList[index]),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInstProff(Inst: Inst),
            ),
          ).then((value) => cargardatos());
        },
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Profesional> temporal1 =
        await ProfesionalController.getInstProfesional(Inst);
    List<Usuario> temporal2 = [];
    await Future.forEach(
        temporal1,
        (proff) async =>
            userList.add(await UsuarioController.getProffUsuario(proff)));
    if (mounted) {
      setState(() {
        proffList = temporal1;
        userList = temporal2;
      });
    }
  }
}
