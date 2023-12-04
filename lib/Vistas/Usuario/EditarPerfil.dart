import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditarPerfilPassView.dart';
import 'package:image_picker/image_picker.dart';

class EditarPerfil extends StatefulWidget {
  final Usuario User;
  const EditarPerfil({super.key, required this.User});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  late Usuario User;
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  XFile? imgSel = null;
  late ImagenModel tempImg = ImagenModel(name: 'SinRecurso', url: 'SinUrl');
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    User = widget.User;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode:
                _autovalidateMode, // Define el modo de validación automática
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:  (imgSel != null)
                      ? Image.file(File(imgSel!.path)).image
                      : (tempImg.url != 'SinUrl')
                          ? NetworkImage(tempImg.url) as ImageProvider<Object>
                          : AssetImage("assets/images/perfil.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          XFile? selectedImage =
                              await ImagenController.SeleccionarUnaImagen();
                          if (selectedImage != null) {
                            setState(() {
                              imgSel = selectedImage;
                              tempImg = User.picture;
                            });
                          }
                        },
                        child: const Text("Seleccionar Imagen")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (imgSel != null) {
                            setState(() {
                              imgSel = null;
                            });
                          } else {
                            setState(() {
                              tempImg.name = 'SinRecurso';
                              tempImg.url = 'SinUrl';
                            });
                          }
                        },
                        child: const Text("Quitar Imagen")),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre(s)'),
                  controller: name,
                  validator: validate,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Apellido(s)'),
                  controller: lastname,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Celular'),
                  controller: phone,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Dirección:'),
                  controller: address,
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.brown),
                ),
                child: const Text("Cambiar Contraseña"),
                onPressed: (){
                  //Enviar a Pantalla de Cambiar Contraseña
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarPass(User: User),
                    ),
                  ).then((value) => cargardatos());
                }),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                  ),
                  child: Text('Guardar Cambios'),
                  onPressed: () async {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                    if (_formKey.currentState!.validate()) {
                      if (await showEditConfirmation(context)) {

                        User.name = name.text;

                        if (lastname.text.isEmpty) {
                          User.lastname = "SinEspecificar";
                        }else{
                          User.lastname = lastname.text;
                        }
                        if (phone.text.isEmpty) {
                          User.phone = "SinEspecificar";
                        }else{
                          User.phone = phone.text;
                        }
                        if (address.text.isEmpty) {
                          User.address = "SinEspecificar";
                        }else{
                          User.address = address.text;
                        }

                        if (imgSel != null) {
                          User.picture = await ImagenController.SaveOneImagen(
                              "Usuario", User.iduser, imgSel!);
                        } else {
                          if (tempImg.url == "SinUrl" &&
                              User.picture != "SinUrl") {
                            User.picture = tempImg;
                          }
                        }

                        await UsuarioController.updateUsuario(User);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("ACTUALIZADO CON EXITO")));

                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    Usuario tempUser = await UsuarioController.getOneUsuario(User.iduser);
    if (mounted) {
      setState(() {
        User = tempUser;
        tempImg = User.picture;
        name.text = User.name;
        lastname.text = User.lastname;
        address.text = User.address;
        phone.text = User.phone;
      });
    }
  }

  //Muestra la confirmacion de Editar
  Future<bool> showEditConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmación"),
              content: Text("¿Estás seguro de que deseas guardar los cambios?"),
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
                  child: Text("Sí, Guardalos"),
                ),
              ],
            );
          },
        ) ??
        false; // En caso de que el usuario cierre el diálogo sin seleccionar ninguna opción.
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    return null;
  }
}
