import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  Data data;

  ChatModel({
    required this.data,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String answer;
  String question;

  Data({
    required this.answer,
    required this.question,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        answer: json["answer"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "question": question,
      };
}
