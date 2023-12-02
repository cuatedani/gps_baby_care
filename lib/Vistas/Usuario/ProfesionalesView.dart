import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';

import '../../Componente/MenuWidget.dart';

class ProfesionalesView extends StatefulWidget {
  const ProfesionalesView({Key? key}) : super(key: key);

  @override
  State<ProfesionalesView> createState() => _ProfesionalesViewState();
}

class _ProfesionalesViewState extends State<ProfesionalesView> {
  List<Profesional> profesionales = [];
  List<bool> _isOpen = [];

  @override
  void initState() {
    super.initState();
    _cargarProfesionales();
  }

  Future<void> _cargarProfesionales() async {
    List<Profesional> listaProfesionales = await ProfesionalController.getallProfesional();

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
              fontWeight: FontWeight.bold,
              fontSize: 25),
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
                  _isOpen[i] = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  isExpanded: _isOpen[i],
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: CircleAvatar(
                        //backgroundImage: AssetImage(profesionales[i].imagen),
                        child: Icon(Icons.person),
                      ),
                      title: Text(profesionales[i].iduser, style: TextStyle(fontSize: 22)),
                      subtitle: Text(profesionales[i].occupation, style: TextStyle(fontSize: 20)),
                    );
                  },
                  body: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Perfil informativo de ${profesionales[i].iduser} \nDirección: ${profesionales[i].iduser}\nTitulos y estudios: informacion adicional',
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
                            Text(
                              "| Programar una cita",
                              style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
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
