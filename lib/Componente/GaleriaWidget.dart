import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';

class GaleriaWidget extends StatefulWidget {
  final List<ImagenModel>? imagenes;

  GaleriaWidget({required this.imagenes});

  @override
  _GaleriaWidgetState createState() => _GaleriaWidgetState();
}

class _GaleriaWidgetState extends State<GaleriaWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.imagenes!.map((imagen) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    // Implementa aquí la lógica para manejar el onTap en la imagen
                    // Puedes cambiar la imagen, abrir una pantalla de detalle, etc.
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Image.network(
                      imagen.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        Text(
          'Imagen ${currentIndex + 1} de ${widget.imagenes!.length}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
