import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Componente/GaleriaWidget.dart';

class ArticuloPageProff extends StatefulWidget {
  final Articulo art;
  final Profesional proff;
  const ArticuloPageProff({super.key, required this.art, required this.proff});

  @override
  State<ArticuloPageProff> createState() => _ArticuloPageProffState();
}

class _ArticuloPageProffState extends State<ArticuloPageProff> {
  late Articulo Art;
  late Profesional Proff;

  @override
  void initState() {
    Proff = widget.proff;
    Art = widget.art;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Art.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: Art.categories!.map((Categoria category) {
                  return Chip(label: Text(category.name));
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                Art.content,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              if (Art.gallery!.isNotEmpty) GaleriaWidget(imagenes: Art.gallery),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.edit)),
                  SizedBox(width: 16),
                  IconButton(onPressed: () {
                    showDeleteConfirmation(context);
                  }, icon: Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Zona de Metodos
  Future<void> showDeleteConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que quieres eliminar este artículo?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                await ArticuloController.deleteArticulo(Art);
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                Navigator.of(context).pop(); // Cerrar la página actual
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Artículo eliminado correctamente"),
                  ),
                );
              },
              child: Text("Sí, Eliminar"),
            ),
          ],
        );
      },
    );
  }
}
