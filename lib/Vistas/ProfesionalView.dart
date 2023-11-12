import 'package:flutter/material.dart';
class Persona {
  final String nombre;
  final String ocupacion;
  final String imagen;
  final String direccion;

  Persona({required this.nombre, required this.ocupacion, required this.imagen, required this.direccion});
}
class ProfesionalView extends StatefulWidget {
  const ProfesionalView({Key? key}) : super(key: key);

  @override
  State<ProfesionalView> createState() => _ProfesionalViewState();
}

class _ProfesionalViewState extends State<ProfesionalView> {
  List<Persona> personas = [
    Persona(nombre: 'Dr. Juan Antonio', ocupacion: 'Psicologo', imagen: 'assets/images/juan.jpg', direccion: 'Colosio #30'),
    Persona(nombre: 'Dra. María Elena', ocupacion: 'Pediatra', imagen: 'assets/images/maria.jpg',direccion: 'Av. mexico #30'),
    Persona(nombre: 'Lic. Pedro', ocupacion: 'Puericultor', imagen: 'assets/images/pedro.jpg',direccion: 'Colosio #30'),
  ];

List<bool> _isOpen = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
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
            for (int i = 0; i < personas.length; i++)
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
                          //backgroundImage: AssetImage(personas[i].imagen),
                          child: Icon(Icons.person),
                        ),
                        title: Text(personas[i].nombre,style: TextStyle( fontSize: 22),),
                        subtitle: Text(personas[i].ocupacion,style: TextStyle( fontSize: 20),),
                      );
                    },
                    body: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Perfil informativo de ${personas[i].nombre} \nDirección: ${personas[i].direccion}\nTitulos y estudios: informacion adicional',
                            style: TextStyle(fontSize: 18,),),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text("Contactar ",style: TextStyle(color: Colors.blueAccent, fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("| Programar una cita",style: TextStyle(color: Colors.blueAccent, fontSize: 18,fontWeight: FontWeight.bold),)
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
      );
  }
}
