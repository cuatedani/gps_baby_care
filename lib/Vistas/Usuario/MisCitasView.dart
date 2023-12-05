import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/citaController.dart';
import 'package:gps_baby_care/Modelos/citaModel.dart';

class MisCitasView extends StatefulWidget {
  final Usuario User;
  const MisCitasView({super.key, required this.User});

  @override
  State<MisCitasView> createState() => _MisCitasViewState();
}

//Falta Hacer Modelo y Controller para las Citas
//Aqui apareceran las citas del Usuario,
//Tendra filtro por estado(Proximas, Anteriores) y texto
//Redirige a CitaPageView muestra info de la Cita, del Paciente
//, Profesional, Istituto, Y rediroge a sus Paginas

class _MisCitasViewState extends State<MisCitasView> {
  late Usuario User;
  List<Cita> citasList = [];

  @override
  void initState() {
    User = widget.User;
    cargarCitas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Citas"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: citasList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("ID Cita: ${citasList[index].idCita}"),
                    subtitle: Text("Motivo: ${citasList[index].motivo}"),
                    // Agrega más detalles de la cita si es necesario
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
    List<Cita> citas = await CitaController.getCitasByUserId(User.iduser);
    if (mounted) {
      setState(() {
        citasList = citas;
      });
    }
  }
}
