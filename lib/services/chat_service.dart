import 'package:flutter_chatgpt_tutorial_yt/models/chat_model.dart';
import 'package:flutter_chatgpt_tutorial_yt/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import json library for JSON encoding/decoding
import 'dart:developer';

class ChatService extends BaseService {
  Future<ChatModel?> chatapi(String question) async {
    try {
      var uri = Uri.parse('http://127.0.0.1:5000/ask');
      var response = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'question': question}));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        // Check if the response contains "data" field
        if (responseData.containsKey('data')) {
          // Deserialize the JSON response into a ChatModel object
          return ChatModel.fromJson(responseData['data']);
        }
      }
      // Return null if the response format is incorrect or if data is missing
      return null;
    } catch (e) {
      log('Error == $e');
      // Return null in case of an error
      return null;
    }
  }
}
