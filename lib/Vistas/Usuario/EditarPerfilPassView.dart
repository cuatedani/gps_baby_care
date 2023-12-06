import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool obscureText2=true; bool obscureText1=true;
  bool obscureText3=true;


  @override
  void initState() {
    User = widget.User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(title: const Text("Cambiar Contraseña")),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            autovalidateMode:
                _autovalidateMode, // Define el modo de validación automática
            child: Column(
              children: [
                SizedBox(height: 50,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Contraseña Actual",
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.0), // Ajusta el margen izquierdo del ícono
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock),
                          ],
                        )),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText1 = !obscureText1;
                        });
                      },
                      icon: Icon(
                        obscureText1 ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  obscureText: obscureText1,
                  controller: oldpass,
                  validator: valoldpass,
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nueva Contraseña",
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.0), // Ajusta el margen izquierdo del ícono
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock),
                          ],
                        )),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText2 = !obscureText2;
                        });
                      },
                      icon: Icon(
                        obscureText2 ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  obscureText: obscureText2,
                  controller: newpass,
                  validator: valnewpass,
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.0), // Ajusta el margen izquierdo del ícono
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock),
                          ],
                        )),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText3 = !obscureText3;
                        });
                      },
                      icon: Icon(
                        obscureText3 ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  obscureText: obscureText3,
                  controller: confirm,
                  validator: valconfirm,
                ),
                SizedBox(height: 25,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: const Text("Guardar Nueva Contraseña", style: TextStyle(fontSize: 15),),
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
                      },
                    style: ButtonStyle(
                      fixedSize:
                      MaterialStateProperty.all<Size>(Size(300, 45)),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),)
                ),

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
                  child: Text("Sí"),
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
