// part of 'chat_cubit.dart';

// @immutable
//  class ChatState {}

//  class CubitInitial extends ChatState {}

import 'package:flutter/material.dart';

class ChatState {
  final List<Message> messages;

  ChatState({required this.messages});

  ChatState copyWith({List<Message>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }
}

class Message {
  final String text;
  final bool isUserMessage;

  Message({required this.text, required this.isUserMessage});
}

