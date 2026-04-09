import 'dart:convert';
import 'package:http/http.dart' as http;

class AiApiService {
  static Future<String> getDiagnosis(String input) async {
    final response = await http.post(
      Uri.parse("http://localhost:5000/diagnose"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"symptoms": input}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["result"];
    } else {
      return "Error connecting to AI server";
    }
  }
}
