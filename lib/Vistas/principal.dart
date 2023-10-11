import 'package:flutter/material.dart';
import 'login.dart';
import 'bienvenida.dart';
import 'menu_principal.dart';
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
        return Login();
      }
      
    }
    return ListView();
  }
}
