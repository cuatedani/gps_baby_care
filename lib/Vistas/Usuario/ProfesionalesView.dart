import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalPageView.dart';

import '../../Componente/MenuWidget.dart';

class ProfesionalesView extends StatefulWidget {
  const ProfesionalesView({Key? key}) : super(key: key);

  @override
  State<ProfesionalesView> createState() => _ProfesionalesViewState();
}

class _ProfesionalesViewState extends State<ProfesionalesView> {
  List<Profesional> profflist = [];
  List<Usuario> userlist = [];

  @override
  void initState() {
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consulta a un Experto",
          style: TextStyle(fontSize: 23),
        ),
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF9F3E5),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Los lugares de origen de todos los profesionales presentados han sido avalados, certificados y verificados para garantizar su calidad.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            const Text("Filtros"),
            Expanded(
              child: (profflist.isEmpty)
                  ? Text("No hay Profesionistas registrados")
                  : ListView.builder(
                itemCount: profflist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Instituto? tempInst = await InstitutoController.getOneInstituto(profflist[index].idinstitute);
                      // Navegar a la página ProfesionalPageView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfesionalPageView(
                            Proff: profflist[index],
                            User: userlist[index],
                            Inst: tempInst!,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: (userlist[index].picture.url !=
                            'SinUrl')
                            ? NetworkImage(userlist[index].picture.url)
                        as ImageProvider<Object>
                            : AssetImage("assets/images/perfil.png")
                        as ImageProvider<Object>,
                      ),
                      title: Text("${userlist[index].name} ${userlist[index].lastname}"),
                      subtitle: Text(profflist[index].occupation),
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
    List<Profesional> tempproffList = await ProfesionalController.getAllProfesional();

    List<Usuario> tempuserList = [];
    await Future.forEach(
        tempproffList,
            (proff) async =>
            tempuserList.add(await UsuarioController.getOneUsuario(proff.iduser)));

    if (mounted) {
      setState(() {
        profflist = tempproffList;
        userlist = tempuserList;
      });
    }
  }
}
