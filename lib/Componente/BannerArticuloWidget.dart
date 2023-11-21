import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

Widget BannerArticulo(Articulo Art) {
  String? ImgPortada() {
    if (Art.gallery != null && Art.gallery!.isNotEmpty) {
      return Art.gallery!.first;
    } else {
      return "assets/images/img_5.png";
    }
  }

  return Container(
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff9BDBE7),
    ),
    child: Row(
      children: [
        Container(
          width: 200,
          height: double.infinity, // Asegura que la imagen tenga la misma altura que el contenedor
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("${ImgPortada()}"),
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Art.categories != null && Art.categories!.isNotEmpty
                  ? Wrap(
                children: Art.categories!.map((Categoria category) {
                  return Chip(
                    label: Text(category.name),
                  );
                }).toList(),
              )
                  : Text('Sin Clasificar'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  "${Art.content.trimLeft()}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "Leer más...",
                  style: TextStyle(
                    color: Color(0xff2F0E84),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
