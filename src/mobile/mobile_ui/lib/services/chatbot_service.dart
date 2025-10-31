import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const openAIApiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const String _apiKey = '';
  static const String _url = 'https://api.openai.com/v1/chat/completions';

  Future<String> getChatResponse(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': userInput},
          ],
        }),
      );

      if (response.statusCode != 200) {
        print('Error response body: ${response.body}');
        throw Exception('Failed to load chat response');
      }

      final data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    } catch (e) {
      print('Error occurred: $e');
      rethrow; 
    }
  }
}
