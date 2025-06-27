import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Error during POST request: $e");
    }
  }

  // You can also add GET, PUT, DELETE methods here if needed.
}
