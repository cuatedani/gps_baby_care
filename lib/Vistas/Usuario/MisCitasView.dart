import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/citaController.dart';
import 'package:gps_baby_care/Modelos/citaModel.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import '../../Componente/MenuWidget.dart';

class MisCitasView extends StatefulWidget {
  final Usuario User;

  const MisCitasView({Key? key, required this.User}) : super(key: key);

  @override
  State<MisCitasView> createState() => _MisCitasViewState();
}

class _MisCitasViewState extends State<MisCitasView> {
  late Usuario user;
  List<Cita> citasList = [];

  @override
  void initState() {
    user = widget.User;
    cargarCitas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Citas"),
        leading: MenuWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: citasList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<Profesional>(
                    future: ProfesionalController.getOneProfesional(citasList[index].idProfesional),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Text('No se encontró el profesional');
                      } else {
                        final profesional = snapshot.data!;
                        return ListTile(
                          title: Text("ID Cita: ${citasList[index].idCita}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Motivo: ${citasList[index].motivo}"),
                              Text("Fecha: ${citasList[index].fecha.toString()}"),
                              Text("Profesional: ${profesional.occupation}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _eliminarCita(index); // Llamada a la función eliminar con el índice
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cargarCitas() async {
    List<Cita> citas = await CitaController.getCitasByUserId(user.iduser);

    if (mounted) {
      setState(() {
        citasList = citas;
      });
    }
  }
  void _eliminarCita(int index) async {
    // Lógica para eliminar la cita
    // Puedes mostrar un diálogo de confirmación antes de eliminarla
    bool confirmarEliminacion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que quieres eliminar esta cita?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirmarEliminacion) {
      // Eliminar la cita
      await CitaController.deleteCita(citasList[index].idCita); // Llamada al controlador para eliminar la cita

      // Actualizar la lista de citas después de eliminar
      cargarCitas();
    }
  }
}
