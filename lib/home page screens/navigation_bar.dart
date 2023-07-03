
import 'package:flutter/material.dart';

import 'draft_screen.dart';
import 'home_screenpage.dart';
import 'persistent_bar.dart';



class Navigation_bar extends StatefulWidget {
  const Navigation_bar({Key? key}) : super(key: key);

  @override
  State<Navigation_bar> createState() => _Navigation_barState();
}

class _Navigation_barState extends State<Navigation_bar> {
  int page_index=0;
  List Pages =[
    home_screen(),
    screen2(),
    Draft_Screen(),
    screen4(),
    screen5(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigation_fn(),

      body: Pages[page_index],

    );
  }
  Widget navigation_fn(){
    return BottomNavigationBar(
      selectedItemColor:Colors.indigo ,
      unselectedItemColor: Colors.grey,
      currentIndex: page_index,
      showSelectedLabels: true,
      showUnselectedLabels: false,

      items:[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "الصفحه الرئيسيه"),
        BottomNavigationBarItem(icon: Icon(Icons.list),label: "طلبات"),
        BottomNavigationBarItem(icon: Icon(Icons.folder),label: "مسودات"),
        BottomNavigationBarItem(icon: Icon(Icons.monetization_on),label: "تكلفه"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz),label: "المزيد"),
      ],
      onTap: (val){
        setState(() {
          page_index =val;
        });
      },
    );
  }

}
