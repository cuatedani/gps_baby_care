import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';

Widget BannerArticulo(Articulo Art) {
  return Container(
    margin: EdgeInsets.all(10.0),
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.brown.shade300,

    ),
    child: Row(
      children: [
        Container(
          width: 160,
          height: double.infinity, // Asegura que la imagen tenga la misma altura que el contenedor
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (Art.gallery != null && Art.gallery!.isNotEmpty)
                  ? NetworkImage(Art.gallery![0].url) as ImageProvider<Object>
                  : AssetImage("assets/images/defaultarticle.png")
                      as ImageProvider<Object>,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "${Art.title}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Art.content.length < 40
                    ? Text(
                        '${Art.content}',
                        style: TextStyle(fontSize: 15),
                      )
                    : Text(
                        '${Art.content.substring(0, 40)} ...',
                        style: TextStyle(fontSize: 15),
                      ),
              ),
              SizedBox(height: 30),
              (Art.categories != null && Art.categories!.isNotEmpty)
                  ? CategoriasWidget(Art.categories!)
                  : const Text('Sin Categorias Asignadas'),
            ],
          ),
        ),
      ],
    ),

  );
}
