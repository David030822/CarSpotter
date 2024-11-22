import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.103.203:8000";

  static Future<List<dynamic>> getCarsByDealer(String dealerName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dealer/$dealerName/cars'),
    );

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load cars: ${response.body}');
    }
  }
}
