import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

Widget CategoriasWidget(List<Categoria> categoriesList) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var category in categoriesList)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  "${category.name}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
