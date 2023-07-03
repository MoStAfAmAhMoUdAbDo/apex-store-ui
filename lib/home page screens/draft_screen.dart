import 'package:flutter/material.dart';

class Draft_Screen extends StatelessWidget {
  const Draft_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drafts",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),
      body: Container(

        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.description_sharp ,size: 100,color: Colors.indigo,),
              Text("No Drafts",style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
              Text("There is no drafted sales" ,style: TextStyle(fontSize: 20 ,color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}
