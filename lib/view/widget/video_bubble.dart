import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:intl/intl.dart';

import 'video_player_screen.dart';

class VideoBubble extends StatelessWidget {
  final ChatMessage message;

  const VideoBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: GestureDetector(
        onTap: () {
          Get.to(VideoPlayerScreen(videoPath: message.content));
        },
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: message.isMe ? Colors.green[300] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(message.isMe ? 12 : 0),
              bottomRight: Radius.circular(message.isMe ? 0 : 12),
            ),
          ),
          child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (message.thumbnail != null)
                Stack(
                  children: [
                    Image.file(
                      File(message.thumbnail!),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 4),
              Text(
                DateFormat('hh:mm a').format(
                  DateTime.fromMicrosecondsSinceEpoch(message.timeStamp),
                ),
                style: TextStyle(
                  color: message.isMe ? Colors.white70 : Colors.black54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
