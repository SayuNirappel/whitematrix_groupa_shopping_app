import 'dart:convert';
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
     final response = await http.get(url, headers: {"Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODViNmQ3NTgzNGU1YWE4Y2RhZjE4YjEiLCJpYXQiOjE3NTA4MzUzODUsImV4cCI6MTc1MTQ0MDE4NX0.FSFcXs_RgTC7v17oPWtMseUBfkPxMYsEgK4kLgCSg4E"});
     if(response.statusCode == 200){
       log('data fetched successfully');
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
  
  
  static Future<http.Response?> postData({
  required String endpoint,
  Map<String, dynamic>? data,
}) async {
  final url = Uri.parse(AppConfig.baseUrl + endpoint);
  try {
    final response = await http.post(
      url,
      headers: {
         "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODViNmQ3NTgzNGU1YWE4Y2RhZjE4YjEiLCJpYXQiOjE3NTA4MzUzODUsImV4cCI6MTc1MTQ0MDE4NX0.FSFcXs_RgTC7v17oPWtMseUBfkPxMYsEgK4kLgCSg4E",
         "Content-Type": "application/json"
      },
      body: jsonEncode(data),
    );

    return response; 
  } catch (e) {
    log('❌ Error sending POST request: $e');
    return null;
  }
}
}