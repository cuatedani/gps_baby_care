import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';

Widget BannerArticulo(Articulo Art) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(10),
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff9BDBE7),
    ),
    child: Row(
      children: [
        Image.asset(
          "assets/images/img_5.png",
          width: 150,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Hola',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  "Texto",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Leer más",
                    style: TextStyle(
                      color: Color(0xff2F0E84),
                      fontSize: 18,
                    ),
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