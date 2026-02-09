import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:intl/intl.dart';

import 'image_full.dart';

class ImageBubble extends StatelessWidget {
  final ChatMessage message;
  const ImageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : Radius.circular(16),
          ),
          color: isMe ? Colors.green[300] : Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(ImageFull(file: message.content));
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 250),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.file(File(message.content), fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                DateFormat('hh:mm a').format(
                  DateTime.fromMicrosecondsSinceEpoch(message.timeStamp),
                ),
                style: TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
