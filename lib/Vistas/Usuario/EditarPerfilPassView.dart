import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class EditarPass extends StatefulWidget {
  final Usuario User;
  const EditarPass({super.key, required this.User});

  @override
  State<EditarPass> createState() => _EditarPassState();
}

class _EditarPassState extends State<EditarPass> {
  late Usuario User;

  @override
  void initState() {
    User = widget.User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cambiar Contraseña")),
      body: Padding(
          padding: EdgeInsets.all(5),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Contraseña Actual"),
                ),
                TextFormField(decoration: InputDecoration(labelText: "Nueva Contraseña"),),
                TextFormField(decoration: InputDecoration(labelText: "Confirmación"),),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Cambiar Contraseña"))
              ],
            ),
          )),
    );
  }
}
