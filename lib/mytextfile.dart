import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyTextForm extends StatelessWidget {
  final String hint;
  final String excep;

  final TextEditingController control ;
  const MyTextForm({super.key, required this.hint ,required this.excep ,required this.control});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      decoration: InputDecoration(
        hintText: hint ,
        hintStyle: TextStyle(
          fontSize: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue ,width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red ,width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade300 ,width: 2),
        ),
        errorStyle: TextStyle(fontSize: 15),

      ),
      validator: (val){
        if(val!.isEmpty)
          return "\u26A0 ${AppLocalizations.of(context).pleaseenter} ${excep}";
        else
          return null ;
      },


    );
  }
}
