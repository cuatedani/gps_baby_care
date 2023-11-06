import 'package:flutter/material.dart';
import 'RegistroView.dart';
import '../Componente/botonInicio.dart';
import 'login.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({Key? key}) : super(key: key);

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
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
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                Flexible(flex: 1, child: Container(
                  margin: EdgeInsets.only(right: 100.0),
                  child: Center(
                    child: Image.asset("assets/images/img_19r.png", width: MediaQuery.of(context).size.width / 1.5),
                  ),
                )),
                Flexible(flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                         Expanded(
                          child: WelcomeButton(
                            buttonText: 'Registrarte',
                            onTap: RegistroView(),
                            color: Colors.transparent,
                            textColor: Color(0xFFE2746B),
                          ),
                        ),
                        Expanded(
                          child: WelcomeButton(
                            buttonText: 'Iniciar Sesión',
                            onTap:  Login(),
                            color: Color(0xFFE2746B),
                            textColor: Color(0xFFFAF2E7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

               /* SizedBox(height: 230,),
                GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
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
