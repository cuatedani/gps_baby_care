import 'package:flutter/material.dart';
import 'RegistroView.dart';
import '../../Componente/botonInicio.dart';
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
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                Flexible(flex: 1, child: Container(
                  margin: EdgeInsets.only(right: 100.0),
                  child: Center(
                    child: Image.asset("assets/images/img_19.png", width: MediaQuery.of(context).size.width / 1.5),
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
                            onTap:  LoginView(),
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
