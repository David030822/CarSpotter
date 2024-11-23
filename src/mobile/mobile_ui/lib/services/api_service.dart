import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://da9b-62-210-243-46.ngrok-free.app";
  static Future<Map<String, dynamic>> getCarsByDealer(String dealerName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dealer/$dealerName/cars'),
    );

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body)); 
    } else {
      throw Exception('Failed to load cars: ${response.body}');
    }
  }
}