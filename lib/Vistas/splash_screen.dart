import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bienvenida.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Bienvenida(),
      ));
    });
  }
  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFDD897B), Color(0xFFECA779)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset("assets/images/logo_sinbg.png",width: MediaQuery.of(context).size.width/2,height: 200, ),
            Icon(Icons.edit, size: 80, color: Colors.white
            ),
            SizedBox(height: 20,),
            Text("BabyCare", 
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 32),),
          ]
        )
      ),
    );
  }
}
