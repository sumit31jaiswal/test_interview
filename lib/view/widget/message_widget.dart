import 'package:flutter/material.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:test_interview/view/widget/file_bubble.dart';
import 'package:test_interview/view/widget/image_bubble.dart';
import 'package:test_interview/view/widget/text_bubble.dart';
import 'package:test_interview/view/widget/video_bubble.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return TextBubble(message: message);
      case MessageType.image:
        return ImageBubble(message: message);
      case MessageType.video:
        return VideoBubble(message: message);
      case MessageType.file:
        return FileBubble(message: message);
      default:
        return SizedBox.shrink();
    }
  }
}
