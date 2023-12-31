import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Vistas/Administrador/AddInstitutoView.dart';
import 'package:gps_baby_care/Vistas/Administrador/InstitutoPageAdminView.dart';

import '../../Componente/MenuWidget.dart';

class InstitutosAdminView extends StatefulWidget {
  const InstitutosAdminView({super.key});

  @override
  State<InstitutosAdminView> createState() => _InstitutosAdminViewState();
}

class _InstitutosAdminViewState extends State<InstitutosAdminView> {
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
              child: ListView.builder(
                itemCount: institutesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navegar a la página InstitutoPageAdminView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstitutoPageAdminView(Ins: institutesList[index]),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: (institutesList[index].logo.url != 'SinUrl')
                            ? NetworkImage(institutesList[index].logo.url) as ImageProvider<Object>
                            : AssetImage("assets/images/defaultlogo.png") as ImageProvider<Object>,
                      ),
                      title: Text(institutesList[index].name),
                      subtitle: Text(institutesList[index].description),
                    ),
                  );
                },
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddInstitutoView()))
              .then((value) => cargardatos());
        },
      ),
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

  //Muestra la confirmacion de Eliminar
  Future<void> showDeleteConfirmation(
      BuildContext context, Instituto ins) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content:
              Text("¿Estás seguro de que quieres eliminar este instituto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Eliminar Falso
                ins.isdeleted = true;
                await InstitutoController.updateInstituto(ins);

                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Insituto Eliminado Correctamente"),
                  ),
                );
              },
              child: Text("Sí, Eliminala"),
            ),
          ],
        );
      },
    );
  }
}
