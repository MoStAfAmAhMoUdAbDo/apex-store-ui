
import 'package:flutter/material.dart';

import 'navigation_bar.dart';
class Main_Screen extends StatefulWidget {
  const Main_Screen({Key? key}) : super(key: key);
  static const rout ='/main_test';
  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  @override
  Widget build(BuildContext context) {
    return Navigation_bar();

    //Persistent_nav_Bar();
  }
}
