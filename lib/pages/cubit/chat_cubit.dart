import 'package:bloc/bloc.dart';
import 'package:flutter_chatgpt_tutorial_yt/models/chat_model.dart'; // Adjust this import as per your project structure
import 'package:flutter_chatgpt_tutorial_yt/pages/cubit/chat_state.dart';
import 'package:flutter_chatgpt_tutorial_yt/services/chat_service.dart'; // Adjust this import as per your project structure


class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;

  ChatCubit({required this.chatService}) : super(ChatState(messages: []));

  void sendMessage(String text) async {
    String question = text.trim();

    if (question.isNotEmpty) {
      try {
        var chatModel = await chatService.chatapi(question);
        List<Message> updatedMessages = List.from(state.messages);

        updatedMessages.add(Message(
          text: question,
          isUserMessage: true,
        ));

         updatedMessages.add(Message(
            text: chatModel!.data.answer,
            isUserMessage: false,
          ));

        emit(state.copyWith(messages: updatedMessages));
      } catch (e) {
        List<Message> updatedMessages = List.from(state.messages);
        updatedMessages.add(Message(
          text: 'Error: $e',
          isUserMessage: false,
        ));
        emit(state.copyWith(messages: updatedMessages));
      }
    }
  }
}
