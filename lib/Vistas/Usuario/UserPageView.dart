import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/ProductsWidget.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
class UserPageView extends StatefulWidget {
  final Usuario User;
  const UserPageView({super.key, required this.User});

  @override
  State<UserPageView> createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {
  late Usuario User;
  List<Producto> products = [];

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
        title: const Text("Usuario"),
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
            Divider(),
            const Text("Productos: "),
            (products.isEmpty)
                ? Text("No cuenta con productos a la venta")
                : ProductsWidget(context, products),
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos de la BD
  Future<void> cargardatos() async {
    List<Producto> tempproducts = await ProductoController.getAllUserProductos(User.iduser);
    if (mounted) {
      setState(() {
        products = tempproducts;
      });
    }
  }
}
