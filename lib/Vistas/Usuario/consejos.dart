import 'package:flutter/material.dart';

class Consejos extends StatefulWidget {
  const Consejos({Key? key}) : super(key: key);

  @override
  State<Consejos> createState() => _ConsejosState();
}

class _ConsejosState extends State<Consejos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Image.asset("assets/images/img_4.png"),
          banners("assets/images/img_5.png", "Involúcrate desde el inicio",
              "Un padre activo reconoce, en todas las facetas del cuidado y desarrollo de su bebé..."),
          banners(
              "assets/images/img_6.png",
              "Conecta con tu pequeño por el tacto y por tu voz",
              "La mejor manera de conectar con tu bebé, para así crear un vínculo sólido..."),
          banners(
              "assets/images/img_7.png",
              "Apoya a tu pareja con la alimentación ",
              "La OMS, la UNICEF avalan que la leche materna es el mejor alimento para tu bebé..."),
          banners(
              "assets/images/img_8.png",
              "No descuides tus actividades en pareja ni en solitario",
              "Un recién nacido es uno de los más grandes estresantes que enfrentará tu relación..."),
        ],
      ),
    );
  }

  Widget banners(String img, String titulo, String cuerpo) {
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
            "$img",
            width: 150,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '$titulo',
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
                    "$cuerpo",
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

  Widget banners2(String img, String titulo, String cuerpo) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFDFC4E5),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '$titulo',
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
                  "$cuerpo",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
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
          )),
          Image.asset(
            "$img",
            width: 150,
          ),
        ],
      ),
    );
  }
}
