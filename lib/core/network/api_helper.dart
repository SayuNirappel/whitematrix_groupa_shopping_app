import 'dart:developer';

import 'package:http/http.dart' as http;

class AppConfig {
  static const String baseUrl = "https://myntacloneappbackend-1.onrender.com";
  
}
class ApiHelper {
  static Future <String ?> getData({String? endpoint})async
  {
     final url=Uri.parse(AppConfig.baseUrl+endpoint!);
    try{
     final response = await http.get(url);
     if(response.statusCode == 200){
       return response.body;
     }
     else{
       log("error:${response.statusCode}");
     }
    }
    catch(e){
      log('Error:$e');
    }
    return null;
  }
}