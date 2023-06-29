import 'package:flutter/material.dart';
import 'package:kibumess/pages/food_details.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List foodList=[
    {
      "fName":"Ugali",
      "fPrice":"20",
      "fImage":"assets/images/img1.jpg"
    },
    {
      "fName":"Cabbage",
      "fPrice":"10",
      "fImage":"assets/images/res1.jpg"
    },

    {
      "fName":"Meat",
      "fPrice":"30",
      "fImage":"assets/images/res2.jpg"
    },
    {
      "fName":"Tea",
      "fPrice":"15",
      "fImage":"assets/images/img.png",

    },

    {
      "fName":"Ugali",
      "fPrice":"20",
      "fImage":"assets/images/img1.jpg"
    },
    {
      "fName":"Cabbage",
      "fPrice":"10",
      "fImage":"assets/images/res1.jpg"
    },

    {
      "fName":"Meat",
      "fPrice":"30",
      "fImage":"assets/images/res2.jpg"
    },
    {
      "fName":"Tea",
      "fPrice":"15",
      "fImage":"assets/images/img.png",

    },



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text(
          "Kibu Mess",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],

      ),

      drawer: Drawer(
        child: ListView(
          children:  [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.red
              ),
              accountName: Text("User"), accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(

                child: Icon(Icons.person,size: 30,),
              ),
            ),

            InkWell(
              child: ListTile(
                leading: Icon(Icons.home,color: Colors.red,),
                title: Text("Home"),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
                title: Text("My Orders"),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.settings,color: Colors.red,),
                title: Text("Settings"),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.logout,color: Colors.red,),
                title: Text("Logout"),
              ),
            ),

          ],
        ),
      ),
      body: GridView.builder(
          itemCount: foodList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2
          ),
          itemBuilder: (context,index){
            return SingleFood(
                foodName:foodList[index]['fName'],
                foodPrice:foodList[index]['fPrice'],
                foodImage:foodList[index]['fImage']
            );


          }),
    );
  }
}

class SingleFood extends StatelessWidget {
  final String foodImage;
  final String foodName;
  final String foodPrice;


  SingleFood({
    required this.foodName, required this.foodPrice, required this.foodImage
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("hero"),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetails(
              foodImage_details: foodImage,
              foodName_details: foodName,
              foodPrice_details: foodPrice
          ))),
          child: GridTile(
            footer: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(foodName,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Ksh.$foodPrice"),
                ],
              ),
            ),
            child: Image.asset(foodImage),
          ),
        ),

      ),
    );
  }
}
