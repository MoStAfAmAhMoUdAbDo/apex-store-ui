import 'dart:io';
import 'package:apex/api_directory/login_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../home page screens/items.dart';

class getHomeData{
  int pagesize= 20;
  Future<List<Item>> getCategoryData(int pageNumber) async {
    print("in get data cat");
    List<Item> dataM = [];
    String url ="http://192.168.1.253:8091/api/Store/POSTouch/getItemsOfPOS";

    // String auth=
    //           "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJSb2xlRGV0YWlscyI6IkorT0ZWUlJGVVhIWXNNb1I3VU1ubXc9PSIsIkRCbmFtZSI6InRQSnZkR25tdTZKWFAvNnVuYVQ3V3lNNnBCU3h4UXRsOHdMbi94UXBsQUp2NUNuOGpyZDcwZjNhcVNmTWF0dGgiLCJ1c2VySUQiOiJVT1FUeGFraVNWWTdhbEE0VlNjUDRRPT0iLCJFbmRQZXJpb2RPbkVuZFBlcmlvZE9uIjoiMTgvMDYvMjAyNCAxMjowMDowMCDYtSIsImVtcGxveWVlSWQiOiJVT1FUeGFraVNWWTdhbEE0VlNjUDRRPT0iLCJDTCI6IlhvbGgzWXovVHkwZEtWSDVDaUUzdWc9PSIsImlzUE9TRGVza3RvcCI6IjAiLCJpc1BlcmlvZEVuZGVkIjoiRmFsc2UiLCJleHAiOjE2ODgzOTQ4ODQsImlzcyI6Imh0dHA6Ly93d3cuVGVzdC5jb20iLCJhdWQiOiJodHRwOi8vd3d3LlRlc3QuY29tIn0.lw4SS5N6g6bB1DA53ggJ6QOhmbIlJ_pgyI-daDW6nPs";
    String auth="Bearer ${loginapi.token}";
    Map<String, dynamic> queryParameter = {
      "PageSize": pagesize.toString(),
      "PageNumber": pageNumber.toString(),
      "categoryId": "1",
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    print(queryString);

    String requestUrl = url+'?'+queryString;
    try {
      print("in try func");
      var response =await http.get(Uri.parse(requestUrl), headers: {HttpHeaders.authorizationHeader: auth ,HttpHeaders.contentTypeHeader: 'application/json' } );
       print("statuse code is ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in get data cat");
        var jsonResponse = convert.jsonDecode(response.body);
        for (var c in jsonResponse['data']) {
          dataM.add(Item.fromjson(c));
        }
      } else {
        print("data faild ");
      }
    } catch (e) {
      print('Unknown exception: $e');
    }
    return dataM;
  }
}

