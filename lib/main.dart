
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/chat_page.dart';
import 'package:flutter_chatgpt_tutorial_yt/router/routers.dart';
import 'package:no_context_navigation/no_context_navigation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETL Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: ChatPage(),
      initialRoute: Routers.chatPage,
       onGenerateRoute: Routers.generateRoute,
       navigatorKey: NavigationService.navigationKey,
       
    );
  }
}


