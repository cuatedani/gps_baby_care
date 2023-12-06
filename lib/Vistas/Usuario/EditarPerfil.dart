import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: (imgSel != null)
                      ? Image.file(File(imgSel!.path)).image
                      : (tempImg.url != 'SinUrl')
                          ? NetworkImage(tempImg.url) as ImageProvider<Object>
                          : AssetImage("assets/images/perfil.png"),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _displayBS(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white70),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        CircleBorder()),
                  ),
                  child: SvgPicture.asset("assets/images/CameraIcon.svg"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 150.0, right: 16, left: 16),
              child: Form(
                key: _formKey,
                autovalidateMode:
                    _autovalidateMode, // Define el modo de validación automática
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nombre(s)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: name,
                      validator: validate,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Apellido(s)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: lastname,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: phone,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Dirección',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: address,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Guardar Cambios'),
                          onPressed: () async {
                            setState(() {
                              _autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                            if (_formKey.currentState!.validate()) {
                              if (await showEditConfirmation(context)) {
                                User.name = name.text;

                                if (lastname.text.isEmpty) {
                                  User.lastname = "SinEspecificar";
                                } else {
                                  User.lastname = lastname.text;
                                }
                                if (phone.text.isEmpty) {
                                  User.phone = "SinEspecificar";
                                } else {
                                  User.phone = phone.text;
                                }
                                if (address.text.isEmpty) {
                                  User.address = "SinEspecificar";
                                } else {
                                  User.address = address.text;
                                }

                                if (imgSel != null) {
                                  User.picture =
                                      await ImagenController.SaveOneImagen(
                                          "Usuario", User.iduser, imgSel!);
                                } else {
                                  if (tempImg.url == "SinUrl" &&
                                      User.picture != "SinUrl") {
                                    User.picture = tempImg;
                                  }
                                }

                                await UsuarioController.updateUsuario(User);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("ACTUALIZADO CON EXITO")));

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
                          ),
                        )),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("Cambiar Contraseña"),
                          onPressed: () {
                            //Enviar a Pantalla de Cambiar Contraseña
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarPass(User: User),
                              ),
                            ).then((value) => cargardatos());
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
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  Future _displayBS(BuildContext context) async {
    return showModalBottomSheet(
        backgroundColor: Colors.brown.shade500,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (context) => Container(
             padding: const EdgeInsets.only(top: 35.0, left: 20),
              height: (150),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.image, // Icono predefinido de Flutter (en este caso, una estrella)
                        color: Colors.white, // Color del icono
                        size: 30.0, // Tamaño del icono
                      ),
                      SizedBox(width: 8,),
                      TextButton(
                          onPressed: () async {
                            XFile? selectedImage =
                            await ImagenController.SeleccionarUnaImagen();
                            if (selectedImage != null) {
                              setState(() {
                                imgSel = selectedImage;
                                tempImg = User.picture;
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("Nueva foto de perfil", style: TextStyle(color: Colors.white),)),

                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.delete_outline, // Icono predefinido de Flutter (en este caso, una estrella)
                        color: Colors.red, // Color del icono
                        size: 30.0, // Tamaño del icono
                      ),
                      SizedBox(width: 8,),
                      TextButton(
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
                            Navigator.pop(context);
                          },
                          child: const Text("Eliminar foto actual", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),

                    ],
                  ),
                  TextButton(
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
                      child: const Text("Eliminar foto actual")),
                ],
              ),
            ));
  }

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
                  child: Text("Sí"),
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
