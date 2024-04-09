import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/chat_page.dart';

class Routers{
  static const String chatPage = "chatPage";

   static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chatPage:
        return MaterialPageRoute(
          builder: ((context) =>  ChatPage()),
        );
        default:
        return MaterialPageRoute(builder: (context) => const DefaulPage());
        }
        }
}

class DefaulPage extends StatelessWidget {
  const DefaulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Not found page'),
      ),
    );
  }
}