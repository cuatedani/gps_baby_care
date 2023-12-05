import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Vistas/Usuario/FormularioCita.dart';

import '../../Componente/MenuWidget.dart';

class ProfesionalesView extends StatefulWidget {
  const ProfesionalesView({Key? key}) : super(key: key);

  @override
  State<ProfesionalesView> createState() => _ProfesionalesViewState();
}

class _ProfesionalesViewState extends State<ProfesionalesView> {
  List<Profesional> profesionales = [];
  late Usuario usuario;
  List<bool> _isOpen = [];

  @override
  void initState() {
    super.initState();
    _cargarProfesionales();
  }

  Future<void> _cargarProfesionales() async {
    List<Profesional> listaProfesionales = await ProfesionalController.getAllProfesional();

    setState(() {
      profesionales = listaProfesionales;
      _isOpen = List.generate(profesionales.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consulta a un experto",
          style: TextStyle(
              fontSize: 23),
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
          SizedBox(height: 10,),
          Divider(),
          for (int i = 0; i < profesionales.length; i++)
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isOpen[i] = isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  isExpanded: _isOpen[i],
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return FutureBuilder(
                      future: UsuarioController.getOneUsuario(profesionales[i].iduser),
                      builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                        } else if (snapshot.hasData) {
                          // Mostrar el nombre del profesional en lugar del iduser
                          return ListTile(
                            leading: CircleAvatar(
                              //backgroundImage: AssetImage(profesionales[i].imagen),
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              '${snapshot.data!.name} ${snapshot.data!.lastname}', // Mostrar el nombre completo del profesional
                              style: TextStyle(fontSize: 22),
                            ),
                            subtitle: Text(
                              profesionales[i].occupation,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error al cargar el nombre del profesional'); // Manejo de errores si falla la obtención de datos
                        } else {
                          return Text('No se encontraron datos'); // Manejo si no hay datos disponibles
                        }
                      },
                    );
                  },

                  body: Container(
                    padding: EdgeInsets.all(16.0),
                    child: FutureBuilder(
                      future: UsuarioController.getOneUsuario(profesionales[i].iduser),
                      builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                        } else if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Perfil informativo de ${snapshot.data!.name} ${snapshot.data!.lastname}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Dirección: ${snapshot.data!.address}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Títulos y estudios: información adicional',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Contactar ",
                                    style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Obtener el ID del usuario (aquí asumiendo que tienes acceso a él)
                                      String idUsuario = snapshot.data!.iduser; // Reemplaza 'ID_USUARIO' con la lógica real para obtener el ID del usuario

                                      // Navegar a la pantalla del formulario de cita
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FormularioCita(
                                            idProfesional: profesionales[i].idprof,
                                            idUsuario: idUsuario,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Programar una cita",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                  )

                                ],
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error al cargar la información del profesional'); // Manejo de errores si falla la obtención de datos
                        } else {
                          return Text('No se encontraron datos'); // Manejo si no hay datos disponibles
                        }
                      },
                    ),
                  ),
                )
              ],
            )
        ],
      ),
    ),
    );
  }
}
