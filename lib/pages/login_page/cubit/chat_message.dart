import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/chat_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
        alignment: message.isUserMessage
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: message.isUserMessage ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: buildMessageBody(),
        ),
      ),
    );
  }

  Widget buildMessageBody() {
    return RichText(
      text: TextSpan(
        children: [
          if (message.isUserMessage)
            TextSpan(
              text: message.text,
              style: const TextStyle(color: Colors.white),
            )
          else
            ..._buildMessageWithLinks(),
        ],
      ),
    );
  }

  List<TextSpan> _buildMessageWithLinks() {
    final List<TextSpan> textSpans = [];
    final RegExp linkRegExp = RegExp(
      r'https?:\/\/\S+',
      caseSensitive: false,
    );
    final String messageText = message.text;
    final Iterable<Match> matches = linkRegExp.allMatches(messageText);

    int previousEnd = 0;
    for (final Match match in matches) {
      final String url = messageText.substring(match.start, match.end);
      if (match.start > previousEnd) {
        textSpans.add(
          TextSpan(
            text: messageText.substring(previousEnd, match.start),
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
      textSpans.add(
        TextSpan(
          text: url,
          style:const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchURL(url);
            },
        ),
      );
      previousEnd = match.end;
    }

    if (previousEnd < messageText.length) {
      textSpans.add(
        TextSpan(
          text: messageText.substring(previousEnd),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return textSpans;
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
// Test git push
