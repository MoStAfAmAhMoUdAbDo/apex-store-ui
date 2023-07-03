import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class loginapi with ChangeNotifier {
  var result;
  static String token ="";
  bool _load = false;
  bool get loaded => _load;
  checkloding(bool val) {
    _load = val;
    print("the value of val of chec is ${val.toString()}");
    notifyListeners();
  }

  Future<int> logincheck(String user_name, password, company_name) async {
    checkloding(true);
    _load=true;

    var login_url = 'http://192.168.1.253:8091/api/Login';

    try {
      var url = Uri.parse(login_url);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: convert.jsonEncode({
            'companyName': company_name,
            'username': user_name,
            'password': password
          }));
      if (response.statusCode == 200) {
        checkloding(false);
        _load=true;
        var data = convert.jsonDecode(response.body);
        result = data['result'];
        if (result == 1) {
          token = data['data']['authToken']['token'];

          print("scucess");
          print("token in login provider $token");
          notifyListeners();
        }
      } else {
        print("faild login");
        checkloding(false);
      }
    } catch (e) {
      print(e.toString());
      checkloding(false);
    }
    notifyListeners();
    return result;
  }
  String get_token(){
    return token;
  }
}

// class login_request{
//   String name;
//   String password;
//   String companyname;
//   //String check;
//   login_request({required this.name,required this.password,required this.companyname});
//
//   Map<String,dynamic> tojson(){
//     Map<String,dynamic> map={
//       "companyName":companyname,
//       "username" :name,
//       "password":password,
//
//
//       // "rememberMe":check,
//     };
//     return map;
//   }
// }
