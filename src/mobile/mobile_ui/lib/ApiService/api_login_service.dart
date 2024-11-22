import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<bool> loginUser(String email, String password, BuildContext context) async {
  final url = 'http://192.168.103.203:5000/login'; // Flask backend URL

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login
      return true;
    } else {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${json.decode(response.body)["message"]}')),
      );
      return false;
    }
  } catch (e) {
    // Network error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Network error: $e')),
    );
    return false;
  }
}
