import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditarPerfil.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditarPerfilPassView.dart';
class PerfilView extends StatefulWidget {
  final Usuario User;
  const PerfilView({super.key, required this.User});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  late Usuario User;

  //Esto se debe eliminar, su funcionalidad se cambio a EditarPerfil,
  //Sera utilizado para perfil de Usuario y Administrador

  @override
  void initState() {
    User = widget.User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: const Text("Mi Perfil"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: (User.picture.url != 'SinUrl')
                  ? NetworkImage(User.picture.url) as ImageProvider<Object>
                  : AssetImage("assets/images/perfil.png")
              as ImageProvider<Object>,
            ),
            Text("${User.name} ${User.lastname}"),
            Divider(),
            Text("Email: ${User.email}"),
            Text("Telefono: ${User.phone}"),
            Text("Direccion: ${User.address}"),
            ElevatedButton(onPressed: (){
              //Enviar a Pantalla de Cambiar Contraseña
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarPass(User: User),
                ),
              ).then((value) => cargardatos());
            }, child: const Text("Cambiar Contraseña")),
            ElevatedButton(onPressed: (){
              //Enviar a Pantalla de Editar Perfil
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditarPerfil(User: User),
                ),
              ).then((value) => cargardatos());
            }, child: const Text("Editar Perfil")),
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos de la BD
  Future<void> cargardatos() async {
    Usuario temporal = await UsuarioController.getOneUsuario(User.iduser);
    if (mounted) {
      setState(() {
        User = temporal;
      });
    }
  }
}
