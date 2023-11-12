import 'package:flutter/material.dart';
import 'LoginView.dart';
import 'BienvenidaView.dart';
import 'MenuPrincipalView.dart';
import 'store.dart';


class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _indice=1;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child: Text(""));
  }

  Widget Pantalla() {
    switch(_indice){
      case 1:{
         return Bienvenida();
      }
      case 2:{
        return LoginView();
      }
      
    }
    return ListView();
  }
}
