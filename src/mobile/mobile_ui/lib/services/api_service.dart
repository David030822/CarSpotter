import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://caf5-62-210-243-45.ngrok-free.app";
  // Dealer API hívás
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

   // Regisztrációs API hívás
  static Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    String profileUrl =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
  }) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": int.tryParse(phone) ?? 0,
        "password": password,
        "profile_url": profileUrl,
      }),
    );

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } else {
      final errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse["detail"] ?? "Unknown error occurred");
    }
  }


  static Future<bool> loginUser(String email, String password) async {
    final String url = "$baseUrl/login";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // await saveToken(data['access_token']);
        return true; 
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['detail'] ?? "Invalid credentials");
      }
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }
}
