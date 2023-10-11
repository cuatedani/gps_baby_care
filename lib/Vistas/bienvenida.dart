import 'package:flutter/material.dart';
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
        color: Color(0xFFFAF2E7),
        child: Stack(
          children: <Widget>[
            Column(

              children: [
                SizedBox(height: 50,),
                Center(
                  child: Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width/2,height: 200, ),
                ),
                SizedBox(height: 20,),
                Text("Bienvenido a", style: TextStyle(color: Colors.brown,fontSize: 40,fontWeight: FontWeight.bold)),
                Text("BabyCare", style: TextStyle(color: Colors.brown,fontSize: 40,fontWeight: FontWeight.bold)),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
                  },
                  child:
                  CircleAvatar(
                    child: Icon(Icons.chevron_right,color: Color(0xFFE2746B), size: 90,),
                    backgroundColor: Color(0xFfC0D0E8),
                    radius: 45,

                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
