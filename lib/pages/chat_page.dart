import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();
  List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ETL Services'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatMessage(
                  message: message,
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
  controller: _textController,
  decoration: InputDecoration(
    hintText: 'How can I help you',
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    suffixIcon: IconButton(
      icon: Icon(Icons.send),
      onPressed: () => _sendMessage(_textController.text.trim()),
    ),
  ),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.send),
          //   onPressed: () => _sendMessage(_textController.text.trim()),
          // ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    String question = text.trim();
    _textController.clear();

    if (question.isNotEmpty) {
      var url = Uri.parse("http://127.0.0.1:5000/ask");
      var body = jsonEncode({"question": question});
      var headers = {'Content-Type': 'application/json'};

      try {
        var response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          setState(() {
            _messages.add(
              Message(
                text: question,
                isUserMessage: true,
              ),
            );
            _messages.add(
              Message(
                text: data['data']['answer'],
                isUserMessage: false,
              ),
            );
          });
        } else {
          setState(() {
            _messages.add(
              Message(
                text: 'Error: ${response.statusCode}',
                isUserMessage: false,
              ),
            );
          });
        }
      } catch (e) {
        setState(() {
          _messages.add(
            Message(
              text: 'Error: $e',
              isUserMessage: false,
            ),
          );
        });
      }
    }
  }
}

class Message {
  final String text;
  final bool isUserMessage;

  Message({
    required this.text,
    required this.isUserMessage,
  });
}

class ChatMessage extends StatelessWidget {
  final Message message;

  const ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: message.isUserMessage ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}