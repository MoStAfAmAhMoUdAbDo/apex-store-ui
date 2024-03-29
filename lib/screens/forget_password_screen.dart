//import 'package:apex/passwordtext.dart';
import 'package:apex/main.dart';
import 'package:apex/model.dart';
import 'package:apex/mytextfile.dart';
import 'package:apex/passwordtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'passwordtext.dart';
 import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({Key? key}) : super(key: key);
  static const rout='/forgetpassword';


  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  final TextEditingController companytxt =TextEditingController();
  final TextEditingController emailtxt =TextEditingController();
  bool lang =true;
  final formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sendbutton=_sendbtn();
    var logopar =_Logo_par();
    var LogoText =_Logo_text();
    var textfield =_alltextfiled(sendbutton);

    return Scaffold(
      appBar: AppBar(),
      // drawer: Drawer(
      //   surfaceTintColor:Colors.red ,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logopar,
                Center(
                  child: LogoText,
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: formkey,
                    child:textfield,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  _Logo_par(){
    return ListTile(
      leading: Image.asset("images/logo (1).jpg" ,fit: BoxFit.fill,),
      trailing:ElevatedButton(
        onPressed: () {
          context.read<modelprovider>().changedriction();
          lang =!lang;
          formkey.currentState!.reset();
        },
        child: Text(' ${AppLocalizations.of(context).english}' ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
        ),
        ),
        style: ElevatedButton.styleFrom(
          //shape:OutlineInputBorder(borderRadius: 5),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  _Logo_text(){
    return Container(
        padding: EdgeInsets.only(top: 10),
    child: Text(
    '${AppLocalizations.of(context).forgetpasslogo}',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    );
  }

  _alltextfiled(Widget btn){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: EdgeInsets.only(top: 25, bottom: 20),
          child: Text('${AppLocalizations.of(context).companyname}'),
        ),
        MyTextForm( hint: '${AppLocalizations.of(context).companyname}' ,excep: '${AppLocalizations.of(context).companyname}',control: companytxt),
        Container(
          padding: EdgeInsets.only(top: 25, bottom: 20),
          child: Text('${AppLocalizations.of(context).email}'),
        ),
        MyTextForm(hint: '${AppLocalizations.of(context).email}' ,excep:'${AppLocalizations.of(context).email}',control: emailtxt, ),

    Container(
    padding: EdgeInsets.only(top: 20),
    width: double.infinity,
    height: 70,
    child: btn,
    ),
      ],
    );
  }
  _sendbtn(){
  return  ElevatedButton(
      onPressed: () {
        if(formkey.currentState!.validate()){

        }

      },
      child: Text('${AppLocalizations.of(context).send}' ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

    );
  }
}




