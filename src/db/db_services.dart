import 'dart:convert';
import 'package:http/http.dart' as http;

class DBService {
  final String baseUrl = "http://localhost"; 

  Future<List<Map<String, dynamic>>> getCars() async {
    final response = await http.get(Uri.parse("$baseUrl/get_cars.php"));
    
    if (response.statusCode == 200) {
      List cars = json.decode(response.body);
      return cars.map((car) => car as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
