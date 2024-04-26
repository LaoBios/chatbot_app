import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/login_page/cubit/chat_message.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  late FocusNode focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'EtlChat',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,//for scroll text up
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
              focusNode: focusNode,
              controller: _textController,
              onSubmitted: (value) {
                _sendMessage(_textController.text.trim());
              },
              decoration: InputDecoration(
                hintText: 'How can I help you',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: (){
                    return  _sendMessage(_textController.text.trim());
                  },
                ),
              ),
            ),
          ),
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
            // question first at 
            _messages.add(
              Message(
                text: question,
                isUserMessage: true,
              ),
            );
            // anwser 
            _messages.add(
              Message(
                text: data['data']['answer'],
                isUserMessage: false,
              ),
            );
          });
          // ເຮັດໃຫ້ຕົວອັກສອນເລື່ນຂື້ນໂອໂຕ
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
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

// class ChatMessage extends StatelessWidget {
//   final Message message;

//   const ChatMessage({
//     Key? key,
//     required this.message,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: message.isUserMessage
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: message.isUserMessage ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(20),//BorderRadius of the message
//           ),
//           child: SelectableText(
//             message.text,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }