import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Componente/GaleriaWidget.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalPageView.dart';

class ProductoProffPageView extends StatefulWidget {
  final Usuario User;
  final Profesional Proff;
  final Instituto Inst;
  final Producto Prod;
  const ProductoProffPageView(
      {super.key,
      required this.User,
      required this.Proff,
      required this.Prod,
      required this.Inst});

  @override
  State<ProductoProffPageView> createState() => _ProductoProffPageViewState();
}

class _ProductoProffPageViewState extends State<ProductoProffPageView> {
  late Usuario User;
  late Profesional Proff;
  late Producto Prod;
  late Instituto Inst;
  List<Categoria> categories = [];
  List<ImagenModel> gallery = [];

  @override
  void initState() {
    User = widget.User;
    Proff = widget.Proff;
    Prod = widget.Prod;
    Inst = widget.Inst;
    categories = Prod.categories!;
    gallery = Prod.gallery!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: const Text("Producto"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Divider(),
            Text(Prod.name),
            Divider(),
            const Text("Categorias: "),
            (categories.isNotEmpty)
                ? CategoriasWidget(categories)
                : const Text("Sin Categorias Asignadas"),
            Divider(),
            if (gallery!.isNotEmpty) GaleriaWidget(imagenes: gallery),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unidades: ${Prod.quantity}"),
                Text("\$${Prod.price}")
              ],
            ),
            Divider(),
            const Text("Descripcion: "),
            Text(Prod.description),
            Divider(),
            const Text("Informacion del Vendedor"),
            InkWell(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: (User.picture.url != 'SinUrl')
                      ? NetworkImage(User.picture.url) as ImageProvider<Object>
                      : AssetImage("assets/images/perfil.png")
                          as ImageProvider<Object>,
                ),
                title: Text("${User.name} ${User.lastname} \n ${Proff.occupation}"),
                subtitle: Text("Contacto ${User.phone}"),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfesionalPageView(
                      User: User,
                      Proff: Proff,
                      Inst: Inst,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
