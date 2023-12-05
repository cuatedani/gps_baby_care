import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/MenuWidget.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/InstitutoPageView.dart';

class InstitutosView extends StatefulWidget {
  const InstitutosView({super.key});

  @override
  State<InstitutosView> createState() => _InstitutosViewState();
}

class _InstitutosViewState extends State<InstitutosView> {
  //Aqui deben de Mostrarse tods los institutos, al hacer click a uno
  //Redirigir a InstitutoPageView, ademas filtrado por texto unicamente
  List<Instituto> institutesList = [];

  @override
  void initState() {
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: const Text("Institutos"),
        leading: MenuWidget(),
      ),
      body: Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Text("Filtros:"),
            Divider(),
            Expanded(
              child: (institutesList.isEmpty)
                  ? Text("No hay Instituciones Registradas Actualmente")
                  :ListView.builder(
                itemCount: institutesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              (institutesList[index].logo.url != 'SinUrl')
                                  ? NetworkImage(institutesList[index].logo.url)
                                      as ImageProvider<Object>
                                  : AssetImage("assets/images/defaultlogo.png")
                                      as ImageProvider<Object>,
                        ),
                        title: Text("${institutesList[index].name}"),
                        subtitle: institutesList[index].description.length < 40
                            ? Text(
                                '${institutesList[index].description}',
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(
                                '${institutesList[index].description.substring(0, 40)} ...',
                                style: TextStyle(fontSize: 15),
                              )),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => InstitutoPageView(
                            Inst: institutesList[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ])),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Instituto> temporal = await InstitutoController.getAllInstituto();
    if (mounted) {
      setState(() {
        institutesList = temporal;
      });
    }
  }
}
