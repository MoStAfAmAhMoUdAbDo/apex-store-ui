// import 'package:flutter/material.dart';
//
// class model {
//   Locale _applocal =Locale('en');
//   Locale get applocal => _applocal?? Locale('en');
//   //var locality ;
//   //Locale getlocality () => _applocal ?? Locale('ar');
//
//    changedriction (){
//     if(_applocal == Locale('ar')){
//       _applocal =Locale('en');
//     }
//     else
//       _applocal =Locale('ar');
//   }
// }

import 'package:flutter/material.dart';

class modelprovider with ChangeNotifier  {
  Locale _applocal =const Locale('ar');
  Locale get applocal => _applocal ;
  //var locality ;
  //Locale getlocality () => _applocal ?? Locale('ar');

  changedriction (){
    if(_applocal == Locale('ar')){
      _applocal =Locale('en');
    }
    else {
      _applocal = Locale('ar');
    }
    notifyListeners();
  }
}