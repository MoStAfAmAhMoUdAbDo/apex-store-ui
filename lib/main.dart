// import 'package:apex/homepage.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return HOmePage();
//   }
// }
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apex/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_directory/login_api.dart';
import 'home page screens/cart_items.dart';
import 'home page screens/home_screenpage.dart';
import 'home page screens/main_screen.dart';
import 'home page screens/menu_provider.dart';
import 'home page screens/persistent_bar.dart';
import 'home page screens/qr_scanner.dart';
import 'screens/loginpagearabe.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model.dart';
void main() {
  runApp(HOmePage());
}

class splash_animated extends StatelessWidget {
  const splash_animated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Icons.home,
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.blue,
      nextScreen: Arab_login(),

    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en',''), // English
        Locale('ar',''),
      ],
      locale: context.watch<modelprovider>().applocal,


      routes: {
        '/' : (context)=>splash_animated(),
        Arab_login.rout : (context)=>Arab_login(),
        Forget_Password.rout :(context)=>Forget_Password(),
        Qr_scanner.rout : (context)=>Qr_scanner(),
        home_screen.rout : (context)=>home_screen(),
        Persistent_nav_Bar.rout : (context) => Persistent_nav_Bar(),
        Main_Screen.rout :(context)=> Main_Screen(),
        // "englogin" : (context)=> LoginPage(),
      },
      initialRoute: '/',
    );
  }
}

class HOmePage extends StatefulWidget {
  const HOmePage({Key? key}) : super(key: key);
  @override
  State<HOmePage> createState() => _HOmePageState();
  // static void setLocale(BuildContext context ,Locale newLocale){
  //   _HOmePageState? state =context.findAncestorStateOfType<_HOmePageState>();
  //   state?.setLocale(newLocale);
  // }
}

class _HOmePageState extends State<HOmePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => modelprovider(),
        ),
        ChangeNotifierProvider(
            create: (context)=>loginapi()),
    ChangeNotifierProvider(
    create: (context) => Cart_Items()),
        ChangeNotifierProvider(
          create: (context) => menuProviderOptions(),)
      ],
      child:MyApp());
  }
}


