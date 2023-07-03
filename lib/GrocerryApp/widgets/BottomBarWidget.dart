import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ksh. 120",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Color(0xFF00A368)),),

              //creating a Custom Button to track
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF00A368),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_shopping_cart,color: Colors.white,size: 20,),
                      SizedBox(width: 5,),
                      Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
