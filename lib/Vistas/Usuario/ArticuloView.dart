import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class ArticuloView extends StatelessWidget {
  final Articulo articulo;

  const ArticuloView({Key? key, required this.articulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Artículo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff9BDBE7),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (articulo.gallery != null && articulo.gallery!.isNotEmpty)
                      ? NetworkImage(articulo.gallery![0].url) as ImageProvider<Object>
                      : AssetImage("assets/images/img_5.png") as ImageProvider<Object>,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              articulo.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              children: articulo.categories != null && articulo.categories!.isNotEmpty
                  ? articulo.categories!.map((Categoria category) {
                return Chip(label: Text(category.name));
              }).toList()
                  : [Chip(label: Text('Sin Clasificar'))],
            ),
            SizedBox(height: 20),
            Text(
              articulo.content,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
