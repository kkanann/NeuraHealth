import 'package:http/http.dart' as http;
import 'dart:convert';

class CohereService {
  static Future<String> getChatbotReply(String userInput) async {
    final response = await http.post(
      Uri.parse(
          'https://us-central1-neurahealth-5c171.cloudfunctions.net/generateText'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': userInput}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['text'].toString().trim();
    } else {
      return "Oops, I'm having trouble responding. Please try again later.";
    }
  }
}
