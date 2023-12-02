import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:image_picker/image_picker.dart';

class AddInstitutoView extends StatefulWidget {
  const AddInstitutoView({super.key});

  @override
  State<AddInstitutoView> createState() => _AddInstitutoViewState();
}

class _AddInstitutoViewState extends State<AddInstitutoView> {
  final name = TextEditingController();
  final desciption = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  XFile? imgSel;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Instituto"),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: name,
                decoration: InputDecoration(labelText: "Nombre:"),
                validator: validateName,
              ),
              SizedBox(height: 10),
              TextField(
                controller: desciption,
                decoration: InputDecoration(labelText: "Descripción:"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: address,
                decoration: InputDecoration(labelText: "Dirección:"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phone,
                decoration: InputDecoration(labelText: "Telefono:"),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      child: const Text("Seleccionar Imagen"),
                      onPressed: () async {
                        XFile? selectedImage = await ImagenController.SeleccionarUnaImagen();
                        setState(() {
                          imgSel = selectedImage;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (imgSel != null)
                Image.file(
                  File(imgSel!.path),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              else
                Text("No has seleccionado una imagen"),
              Divider(),
              FilledButton(
                onPressed: () async {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.onUserInteraction;
                  });

                  if (_formKey.currentState!.validate()) {
                    bool res = await showAddConfirmation(context);

                    if (res) {
                      ImagenModel oneImage =
                          ImagenModel(name: 'SinLogo', url: 'SinUrl');

                      Instituto newInst =
                          await InstitutoController.insertInstituto(
                        Instituto(
                          idinstitute: 'SinEspecificar',
                          name: name.text,
                          phone: phone.text.isEmpty
                              ? 'SinEspecificar'
                              : phone.text,
                          address: address.text.isEmpty
                              ? 'SinEspecificar'
                              : address.text,
                          description: desciption.text.isEmpty
                              ? 'SinEspecificar'
                              : desciption.text,
                          logo: oneImage,
                          isdeleted: false,
                        ),
                      );

                      if (imgSel != null) {
                        ImagenModel saveImage =
                            await ImagenController.SaveOneImagen(
                          'Instituto',
                          newInst.idinstitute,
                          imgSel!,
                        );

                        newInst.logo = saveImage;
                        await InstitutoController.updateInstituto(newInst);
                      }
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Instituto Agregado Correctamente"),
                        ),
                      );
                    }
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Zona de Metodos
  //Muestra la confirmacion de Agregar
  Future<bool> showAddConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmación"),
              content:
                  Text("¿Estás seguro de que deseas agregar la categoría?"),
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
                  child: Text("Sí, Agrégala"),
                ),
              ],
            );
          },
        ) ??
        false; // En caso de que el usuario cierre el diálogo sin seleccionar ninguna opción.
  }

  // Función para validar el nombre de manera asíncrona
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Es necesario un nombre para el Instituto.';
    }
    return null;
  }
}
