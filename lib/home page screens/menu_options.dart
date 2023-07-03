import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu_provider.dart';


class menuOptions extends StatefulWidget {
  const menuOptions({super.key});

  @override
  State<menuOptions> createState() => _menuOptionsState();
}

class _menuOptionsState extends State<menuOptions> {
  bool x=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More" ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25),),
      ),
      body: Card(
        child: Consumer<menuProviderOptions>(builder: (context,provid,child){
          return ListView(
            children: [
              SwitchListTile(
                title: Text("Enable qty popup"),
                secondary: Icon(Icons.table_chart_outlined),
                value:provid.enablePopup, onChanged: (val){
               provid.changePopupData(val);
              },),
              SwitchListTile(
                title: Text("Disable images for product"),
                secondary: Icon(Icons.image),
                value:provid.disableImage , onChanged: (val){
                provid.changeImageData(val);
              },),
            ],
          );
        },)
      ),
    );
  }
}
