import 'package:flutter/material.dart';
import 'RegistroView.dart';
import 'LoginView.dart';

class BienvenidaView extends StatefulWidget {
  const BienvenidaView({Key? key}) : super(key: key);

  @override
  State<BienvenidaView> createState() => _BienvenidaViewState();
}

class _BienvenidaViewState extends State<BienvenidaView> {
  Color colorFondo = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/inicio.jpeg'),
            fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
          ),
        ),
        //color: Color(0xFFFAF2E7) COLOR BASE
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/img_19.png",
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: 250),
                      ]),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistroView()),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "  Registrarte  ",
                            style: TextStyle(
                                fontFamily: 'NerkoOne',
                                fontSize: 18,
                                color: Colors.white),
                          )),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.brown, width: 2.0),
                        shape: StadiumBorder(),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "  Iniciar sesión ",
                            style: TextStyle(
                                fontFamily: 'NerkoOne',
                                fontSize: 18,
                                color: Colors.white),
                          )),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.brown, width: 2.0),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* SizedBox(height: 230,),
                GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()),);
                  },
                  child:
                  CircleAvatar(
                    child: Icon(Icons.chevron_right,color: Color(0xFFFAF2E7), size: 90,),
                    backgroundColor: Color(0xFFE2746B),
                    radius: 45,

                  ),),*/
          ],
        ),
      ),
    );
  }
}
