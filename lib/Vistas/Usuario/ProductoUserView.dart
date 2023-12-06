import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Componente/GaleriaWidget.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditProductoUserView.dart';

class ProductoUserView extends StatefulWidget {
  final Usuario User;
  final Producto Prod;
  const ProductoUserView({super.key, required this.User, required this.Prod});

  @override
  State<ProductoUserView> createState() => _ProductoUserViewState();
}

class _ProductoUserViewState extends State<ProductoUserView> {
  late Usuario User;
  late Producto Prod;
  List<Categoria> categories = [];
  List<ImagenModel> gallery = [];

  @override
  void initState() {
    User = widget.User;
    Prod = widget.Prod;
    categories = Prod.categories!;
    gallery = Prod.gallery!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver Producto"),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(Prod.name),
              Divider(),
              const Text("Categorias: "),
              (categories.isNotEmpty)
                  ? CategoriasWidget(categories)
                  : const Text("Sin Categorias Asignadas"),
              Divider(),
              if (gallery.isNotEmpty) GaleriaWidget(imagenes: gallery),
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
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditProductoUserView(
                                Prod: Prod,
                              ),
                            ))
                            .then((value) => cargardatos());
                      },
                      icon: Icon(Icons.edit)),
                  SizedBox(width: 16),
                  IconButton(
                      onPressed: () async {
                        showConfirmation(context);
                        bool confirmationResult =
                            await showConfirmation(context);
                        if (confirmationResult) {
                          //Codigo para borrar
                          await ProductoController.deleteProducto(
                              Prod.idproduct!);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Zona de Metodos
  //Carga datos de la DB
  Future<void> cargardatos() async {
    Producto? tempProd =
        await ProductoController.getOneProducto(Prod.idproduct!);
    if (mounted) {
      setState(() {
        Prod = tempProd!;
        categories = Prod.categories!;
        gallery = Prod.gallery!;
      });
    }
  }

  //Muestra la confirmacion de Eliminar
  Future<bool> showConfirmation(BuildContext context) async {
    bool res = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que quieres eliminar este producto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                res = true;
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Sí, Eliminalo"),
            ),
          ],
        );
      },
    );
    return res;
  }
}
