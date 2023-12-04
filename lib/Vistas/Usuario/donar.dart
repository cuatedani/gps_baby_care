import 'package:flutter/material.dart';
import '../../Componente/MenuWidget.dart';
class Donar extends StatefulWidget {
  const Donar({Key? key}) : super(key: key);

  @override
  State<Donar> createState() => _DonarState();
}

class _DonarState extends State<Donar> {

  //Esta ventana se podria quitar xd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donación",
          style: TextStyle(
              fontSize: 23),
        ),
        leading: MenuWidget(),
      ),
      body: ListView(
      children: [
        //BANNER PRINCIPAL------------------------------------------------------//////////////////////////////////////////
        Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 2),
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color:Color(0xff88D1C6),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),

          child: Row(
            children: [
              Expanded(
                child:
                Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child:
                      Text("¡Comparte tu amor con una donación!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Color(0xff9174ED))),
                        onPressed: (){},
                        child: Text("Donar"),
                      ),),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset("assets/images/img_9.png",height: 125,),
              ),
            ],
          ),

        ),
        //OPCIONES PARA DONAR---------------------------------------------------////////////////////////////////////////
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Text("Opciones",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff5522A2),),
          ),
        ),
        Container(
          height: 125,
          child:
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                OpcionWidget("assets/images/img_10.png","Juguetes"),
                OpcionWidget("assets/images/img_15.png","Beca"),
                OpcionWidget("assets/images/img_16.png","Apadrina"),
                OpcionWidget("assets/images/img_17.png","Dinero"),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Divider(),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Text("También puedes acudir a tu sitio más cercano en:",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff5522A2),),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:
          Column(
            children: [
              SizedBox(height: 10,),
              Text("Palacio Municipal Tepic",style: TextStyle(fontSize: 25)),

              Image.asset('assets/images/img_18.png',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Dirección: Palacio Municipal Tepic \nPuebla No. 218 Norte\nTepic, Nayarit\nCP 63000\n(311) 265-2791',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );

  }
  Widget OpcionWidget(String imagen,String Texto) {

            return Container(
              width: 120,
              height: 120,

              margin:EdgeInsets.symmetric(horizontal: 10,),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                boxShadow:[ BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                ),],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("$imagen",width: 50,height: 50,),
                  SizedBox(height: 5,),
                  Text("$Texto",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("info"),
                      Icon(Icons.info,size: 18,),
                    ],
                  ),

                ],
              ),
            );
  }
}
/*
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            image: DecorationImage(
              image:AssetImage("assets/images/img_9.png"),
              fit: BoxFit.cover,
            ),

          ),
 */
