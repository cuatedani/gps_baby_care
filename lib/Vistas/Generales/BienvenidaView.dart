import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gps_baby_care/Componente/OnboardingScreen.dart';

import 'LoginView.dart';
import 'RegistroView.dart';

class BienvenidaView extends StatefulWidget {
  const BienvenidaView({super.key});

  @override
  State<BienvenidaView> createState() => _BienvenidaViewState();
}

class _BienvenidaViewState extends State<BienvenidaView> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text":
          "¡Bienvenido a Baby Care!\n\n La solución perfecta para padres preocupados por el crecimiento rápido de sus bebés.",
      "image": "assets/images/OnboardingS1.png"
    },
    {
      "text":
          "¡Dale una segunda vida a la ropa de tu bebé!\n Contribuye a la economía circular mientras ahorras dinero.",
      "image": "assets/images/OnboardingS3.png"
    },
    {
      "text":
          "Contacta con expertos en cuidado infantil.\n Obtén consejos valiosos de pediatras y profesionales.",
      "image": "assets/images/OnboardingS2.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => OnboardingScreen(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color(0xFFFF725E)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      Row(
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
                                ' Registrate ',
                                style: GoogleFonts.lobster(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: .5,
                                      color: Colors.brown.shade400),
                                ),
                              ),
                            ),
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
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                ' Iniciar Sesión ',
                                style: GoogleFonts.lobster(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: .5,
                                    color: Colors.brown.shade400,
                                  ),
                                ),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.brown, width: 2.0),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RegistroView.dart';
import 'LoginView.dart';

class BienvenidaView extends StatefulWidget {
  const BienvenidaView({Key? key}) : super(key: key);

  @override
  State<BienvenidaView> createState() => _BienvenidaViewState();
}

class _BienvenidaViewState extends State<BienvenidaView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
              flex:3,
          child: Column(
            children: [
              Spacer(),
              Text("BABY CARE", style: TextStyle(fontSize: 32)),
              Text("¡Bienvenido a Baby Care! La solución perfecta para mamás y papás preocupados por el crecimiento rápido de sus bebés."),
              Spacer(),
              Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/OnboardingS1.png"),
              )


            ],
          ),
          ),
          Expanded(
              flex:2,
              child: SizedBox())
        ],
      ),
    ));
  }
}

/*Scaffold(
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
                            '  Registrate  ',
                            style: GoogleFonts.lobster(
                              textStyle: TextStyle(
                                fontSize: 20,
                                letterSpacing: .5,
                                color: Colors.white
                              ),
                            ),
                          ),
                      ),
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
                            '  Iniciar Sesión  ',
                            style: GoogleFonts.lobster(
                              textStyle: TextStyle(
                                fontSize: 20,
                                letterSpacing: .5,
                                color: Colors.white,
                              ),
                            ),
                          ),),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.brown, width: 2.0),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
/*],
),
),
); */


 */
