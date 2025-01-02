import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String apiUrl = "https://api.openai.com/v1/completions";
  final String apiKey = "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";

  Future<Map<String, dynamic>> generateTrainingPlan(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          "prompt": prompt,
          "max_tokens": 500,
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return jsonDecode(responseData['choices'][0]['text']);
      } else {
        throw Exception("Fehler: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Fehler bei der Verbindung zur KI: $e");
    }
  }
}
