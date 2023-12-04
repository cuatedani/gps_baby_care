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
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirm = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

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
            key: _formKey,
            autovalidateMode:
                _autovalidateMode, // Define el modo de validación automática
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Contraseña Actual"),
                  controller: oldpass,
                  validator: valoldpass,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nueva Contraseña"),
                  controller: newpass,
                  validator: valnewpass,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirmación"),
                  controller: confirm,
                  validator: valconfirm,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Cambiar Contraseña"))
              ],
            ),
          )),
    );
  }

  //Zona de Metodos
  //Muestra la confirmacion de Editar
  Future<bool> showEditConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que deseas cambiar tu contraseña?"),
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
              child: Text("Sí, Cambiala"),
            ),
          ],
        );
      },
    ) ??
        false; // En caso de que el usuario cierre el diálogo sin seleccionar ninguna opción.
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? valoldpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    return null;
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? valnewpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    return null;
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? valconfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    return null;
  }
}
