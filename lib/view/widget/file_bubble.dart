import 'package:flutter/material.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:intl/intl.dart';

class FileBubble extends StatelessWidget {
  final ChatMessage message;
  const FileBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
          maxHeight: 250,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.content.endsWith('.pdf'))
                  Icon(Icons.picture_as_pdf, size: 40, color: Colors.red)
                else if (message.content.endsWith('.doc'))
                  Icon(Icons.description, size: 40, color: Colors.red)
                else if (message.content.endsWith('.xls'))
                  Icon(Icons.table_chart, size: 40, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message.content.split('/').last,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              DateFormat(
                'hh:mm a',
              ).format(DateTime.fromMicrosecondsSinceEpoch(message.timeStamp)),
              style: TextStyle(color: Colors.black54, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
