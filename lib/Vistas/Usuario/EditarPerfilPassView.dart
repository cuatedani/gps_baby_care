import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
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
                    child: const Text("Cambiar Contraseña"),
                    onPressed: () async {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                      if (_formKey.currentState!.validate()) {
                        if (await showEditConfirmation(context)) {
                          User.password = newpass.text;

                          await UsuarioController.updateUsuario(User);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("CONTRASEÑA ACTUALIZADA")));

                          Navigator.of(context).pop();
                        }
                      }
                    })
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
              content:
                  Text("¿Estás seguro de que deseas cambiar tu contraseña?"),
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

  // Función para validar la contraseña antigua
  String? valoldpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    if (value != User.password) {
      return 'La contraseña no coincide con tu contraseña actual.';
    }

    return null;
  }

  // Función para validar la nueva contraseña
  String? valnewpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    if (value.length < 8) {
      return 'La contraseña debe ser mayor a 8 caracteres.';
    }

    if (value == User.password) {
      return 'Esta contraseña es igual a la anterior.';
    }

    return null;
  }

  // Función para validar la confirmacion
  String? valconfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    if (value != newpass.text) {
      return 'Las contraseñas no coinciden.';
    }

    return null;
  }
}
