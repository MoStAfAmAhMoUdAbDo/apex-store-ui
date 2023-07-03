import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:convert' as convert;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'new_screen.dart';

class pdf_printing extends StatefulWidget {
  const pdf_printing({Key? key}) : super(key: key);

  @override
  State<pdf_printing> createState() => _pdf_printingState();
}

class _pdf_printingState extends State<pdf_printing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: print_pdf_network,
                    child: Text("print pdf"),
                  ),
                  ElevatedButton(
                    onPressed: share_pdf_network,
                    child: Text("share pdf"),
                  ),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pdf_vew_sync() ));
                    },
                    child: Text("new pdf view test"),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Future<dynamic> get_pdf()async{
  var x="";
  String url ="http://192.168.1.253:8091/api/Store/reportsOfMainData/ItemsPricesReportForIOSAndroid";
  String auth ="Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJSb2xlRGV0YWlscyI6IkorT0ZWUlJGVVhIWXNNb1I3VU1ubXc9PSIsIkRCbmFtZSI6Ink4Y29XQ0lTQ3dpa0dRdTViRHc4WlhKNUZvTFZabVVSRy9GSzN3OGVSVHdoYk95MG1MM2pNZnh6WWpsR0ZkRWciLCJ1c2VySUQiOiJVT1FUeGFraVNWWTdhbEE0VlNjUDRRPT0iLCJFbmRQZXJpb2RPbkVuZFBlcmlvZE9uIjoiMTAvMDgvMjAyMyAxMjowMDowMCDYtSIsImVtcGxveWVlSWQiOiJVT1FUeGFraVNWWTdhbEE0VlNjUDRRPT0iLCJDTCI6InFtb3VhU3gzMjNVSEdjMlR6U3lZbUE9PSIsImlzUE9TRGVza3RvcCI6IjAiLCJpc1BlcmlvZEVuZGVkIjoiRmFsc2UiLCJleHAiOjE2ODY5MzI3NTIsImlzcyI6Imh0dHA6Ly93d3cuVGVzdC5jb20iLCJhdWQiOiJodHRwOi8vd3d3LlRlc3QuY29tIn0.RBkT6yEHimHa0vMqjE93pcbbSHkTNaZG25y39-eWyJA";
  Map<String, dynamic> queryParameter = {
  "exportType": "1",
  "isArabic": "true",
  "pageSize": "100",
  "pageNumber": "1",
  "itemId": "0",
  "statues": "0",
  "itemTypes": "0",
  "catId": "0"
  };
  String queryString = Uri(queryParameters: queryParameter).query;
  String requestUrl = url+'?'+queryString;
  var response =await http.get(Uri.parse(requestUrl), headers: {HttpHeaders.authorizationHeader: auth ,HttpHeaders.contentTypeHeader: 'application/json' } );
print("status code${response.statusCode}");
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
   // print("the url in get is ${jsonResponse["result"]["fileURL"]}");
   return jsonResponse["result"]["fileURL"] ;
  } else {
    print("data faild ");
  }
}
//http.Response response = await http.get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
  void print_pdf_network()async{

    //String path= await get_pdf();
    print("on function print");
   // http.Response response = await http.get(Uri.parse(path.toString()));
    var response = await http.get(Uri.parse("http://192.168.1.253:1001/files/ItemsPrices-15062023122609%D9%85.pdf"));
    var pdfData = response.bodyBytes;
    if(response.statusCode==200){
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
    }
    else{
      print("has no data and return false");
    }

  }
  void createpdf()async{
    final doc =pw.Document();
    doc.addPage(pw.Page(pageFormat:PdfPageFormat.a4,
    build: (pw.Context context){
      return pw.Center(
        child: pw.Text("wefqer"),
      );
    }
    ),);
    await Printing.layoutPdf(onLayout: (PdfPageFormat format)async =>doc.save() );
  }

  void share_pdf_network()async {
    //String path= await get_pdf();
    //var data = await http.get(Uri.parse(path.toString()));
    var data = await http.get(Uri.parse("http://192.168.1.253:1001/files/ItemsPrices-15062023122609%D9%85.pdf"));
    if(data.statusCode==200){
      Printing.sharePdf(bytes: data.bodyBytes,filename: "document.pdf");
    }
    else{
      print("data faild to share");
    }

  }

}
