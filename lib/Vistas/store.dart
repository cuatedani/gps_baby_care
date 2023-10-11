import 'package:flutter/material.dart';
class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: [
          Container(

            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFfEADFB4),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Buscar aquí...",
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
                //CATEGORIAS
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Text("Categorias",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5522A2),),
                  ),
                ),
                //CATEGORIAS ------------------------------------------------------------------------------------------------
                CategoriasWidget(),
                //PRODUCTOS ---------------------------------------------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Productos",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5522A2),
                    ),
                  ),
                ),
                ItemsWidget(),
              ],
            ),
          ),
        ],
      )
    );



  }
  Widget CategoriasWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i=1;i<8;i++)
            Container(
              margin:EdgeInsets.symmetric(horizontal: 10,),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/img_1.png",width: 40,height: 40,),
                  Text("Calzado",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blueAccent),)

                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget ItemsWidget() {

    return GridView.count(

      childAspectRatio:  .62,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,

      children: [
        for(int i=11;i<15;i++)
          Container(
            height: 100,
            padding: EdgeInsets.only(left: 15,right: 15,top: 10),
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("-50%",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Image.asset("assets/images/img_$i.png",height: 120,width: 120,),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text("Titulo",style: TextStyle(fontSize: 18,color: Color(0xFF0066CB),fontWeight: FontWeight.bold),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("descripción del producto extensa",style: TextStyle(fontSize: 15),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$55",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.indigo),
                      ),
                      Icon(Icons.shopping_cart_checkout,color: Colors.black,)
                    ],
                  ),
                )
              ],
            ),
          )
      ],

    );
  }
}
