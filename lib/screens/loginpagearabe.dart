import 'package:apex/home%20page%20screens/main_screen.dart';
import 'package:apex/model.dart';
import 'package:apex/passwordtext.dart';
import 'package:apex/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api_directory/get_api.dart';
import '../api_directory/login_api.dart';
import '../customer/customer_data.dart';
import '../homepage.dart';
import '../mytextfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Arab_login extends StatefulWidget {
  const Arab_login({Key? key}) : super(key: key);
  static const rout = '/login';

  @override
  State<Arab_login> createState() => _Arab_loginState();
}

class _Arab_loginState extends State<Arab_login> {
  bool remember = false;
  final formkey = GlobalKey<FormState>();
  bool autovalidate = false;
// model newlocal =new model();
  final TextEditingController companytxt = TextEditingController();
  final TextEditingController usernametxt = TextEditingController();
  final TextEditingController passwordtxt = TextEditingController();
  bool lang = true;
  bool circale_load_flag=false;
  var size;
  @override
  List<customer> newcustomer = [];
  late Future<List<customer>> futureData;
  Getapi? api;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   //futureData =Getapi().Get_data();
  //
  //   api=Getapi();
  //   LoadData();
  // }
  // LoadData() async {
  //   futureData = api!.Get_data();
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }
  // remember,
  // passwordtxt.text.toString(),
  // companytxt.text.toString());
  Save_data(bool rember_me, String company_name, String user_name) async {
    print("saved prefrence");
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("rember_me", rember_me);
    pref.setString("company_name", company_name);
    pref.setString("user_name", user_name);
    get_data();
  }

  get_data() async {
    print("get fn prefrence");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var re = pref.getBool("rember_me");

    // companytxt=TextEditingController(text: "qwefbweblasdbasl");
    if (re == true) {
      companytxt.text = pref.getString("company_name")!;
      usernametxt.text = pref.getString("user_name")!;
    }
  }

  @override
  setsize(bool language) {
    if (language) {
      size = 100.0;
    } else {
      size = 0.0;
    }
    // return size;
  }

  @override
  Widget build(BuildContext context) {
    setsize(lang);
    print("the value of loaded is ${loginapi().loaded.toString()}");
    return Scaffold(
      // appBar: AppBar(),
      // drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.asset(
                      "images/logo (1).jpg",
                      fit: BoxFit.fill,
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        context.read<modelprovider>().changedriction();
                        lang = !lang;
                        formkey.currentState!.reset();
                      },
                      child: Text(
                        ' ${AppLocalizations.of(context).english}',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      style: ElevatedButton.styleFrom(
                        //shape:OutlineInputBorder(borderRadius: 5),

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size.fromWidth(150),

                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '${AppLocalizations.of(context).login}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // PasswordText(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 25, bottom: 20),
                          child: Text(
                              '${AppLocalizations.of(context).companyname}'),
                        ),
                        MyTextForm(
                            hint: '${AppLocalizations.of(context).companyname}',
                            excep:
                                '${AppLocalizations.of(context).companyname}',
                            control: companytxt),
                        Container(
                          padding: EdgeInsets.only(top: 25, bottom: 20),
                          child:
                              Text('${AppLocalizations.of(context).username}'),
                        ),
                        MyTextForm(
                          hint: '${AppLocalizations.of(context).username}',
                          excep: '${AppLocalizations.of(context).username}',
                          control: usernametxt,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25, bottom: 20),
                          child:
                              Text('${AppLocalizations.of(context).password}'),
                        ),
                        PasswordText(
                            hint: '${AppLocalizations.of(context).password}',
                            obsecur: true,
                            control: passwordtxt),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${AppLocalizations.of(context).rememberme}'),
                            Checkbox(
                                value: remember,
                                onChanged: (val) {
                                  setState(() {
                                    remember = val!;
                                  });
                                }),
                            SizedBox(
                              width: size,
                            ),
                            InkWell(
                              child: Text(
                                '${AppLocalizations.of(context).forgetpassword}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                formkey.currentState!.reset();
                                Navigator.pushNamed(
                                    context, Forget_Password.rout);
                              },
                            ),

                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                circale_load_flag =true;
                              });
                              if (formkey.currentState!.validate()) {
                                // check_valide_data();

                                var res = await loginapi().logincheck(
                                    usernametxt.text.toString(),
                                    passwordtxt.text.toString(),
                                    companytxt.text.toString());

                                print("the value of loaded is ${loginapi().loaded.toString()}");
                                if (res == 1) {
                                  circale_load_flag=false;
                                  setState(() {
                                  });
                                  await Save_data(
                                      remember,
                                      companytxt.text.toString(),
                                    usernametxt.text.toString()
                                  );
                                  Navigator.pushReplacementNamed(context,Main_Screen.rout );
                                } else if (res == 0) {
                                  circale_load_flag=false;
                                  setState(() {
                                  });
                                  // print("else if is running ");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Icon(
                                            Icons.thumb_down,
                                            size: 20,
                                          ),
                                          content: Text("OOps"),
                                        );
                                      });
                                }
                              }
                            },
                            child: circale_load_flag
                                ? CircularProgressIndicator(color: Colors.white,)
                                : Text(
                                    '${AppLocalizations.of(context).login}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                            style: ElevatedButton.styleFrom(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              Text('${AppLocalizations.of(context).account}'),
                              InkWell(
                                child: Text(
                                  '${AppLocalizations.of(context).createaccounte}?',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    //decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  validatetext() {
    if (formkey.currentState!.validate()) {
      // data is valid!
      return true;
    } else {
      // Activate autovalidation
      autovalidate = true;
    }
    return false;
  }

  @override
  check_valide_data() async {
    var res = await loginapi().logincheck(usernametxt.text.toString(),
        passwordtxt.text.toString(), companytxt.text.toString());
  }

  @override
  Data_future() {
    return FutureBuilder<List<customer>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          newcustomer = List.from((snapshot.data!));
          return Basic_Bage();
        }
      },
    );
  }

  // onpresed_data(){
  //   return ()async {
  //     if(formkey.currentState!.validate()){
  //       // check_valide_data();
  //       var res =await loginapi().logincheck(usernametxt.text.toString(), passwordtxt.text.toString(), companytxt.text.toString());
  //       //var res =loginapi().result;
  //       if(res==1){
  //         showDialog(context: context, builder: (context){
  //           return AlertDialog(
  //             title: Icon(Icons.thumb_up ,size: 20,),
  //             content: Text("welcom"),
  //           );
  //         });
  //       }
  //       else{
  //         showDialog(context: context, builder: (context){
  //           return AlertDialog(
  //             title: Icon(Icons.thumb_down ,size: 20,),
  //             content: Text("OOps"),
  //           );
  //         });
  //       }
  //     }
  //   };
  //
  // }
  void dispose() {
    super.dispose();
    usernametxt.dispose();
  }
}
