// import 'package:apex/app_local.dart';
// import 'package:apex/loginpage.dart';
// import 'package:flutter/material.dart';
//
// import 'loginpagearabe.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// //import 'package:apex/model.dart';
//
// import 'model.dart';
// void main() {
//   runApp(HOmePage());
// }
// class HOmePage extends StatefulWidget {
//   const HOmePage({Key? key}) : super(key: key);
//
//   @override
//   State<HOmePage> createState() => _HOmePageState();
//   static void setLocale(BuildContext context ,Locale newLocale){
//     _HOmePageState
//   }
//
// }
//
// class _HOmePageState extends State<HOmePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
// debugShowCheckedModeBanner: false,
//       //locale(model.getlocality()),
//
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('en',''), // English
//         Locale('ar',''),
//       ],
//
//       home: Arab_login(),
//       routes: {
//         "arbiclogin" : (context)=>Arab_login(),
//         "englogin" : (context)=> LoginPage(),
//
//       },
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';

class Basic_Bage extends StatelessWidget {
  const Basic_Bage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Text("wellcom",style: TextStyle(fontSize: 180 ,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
