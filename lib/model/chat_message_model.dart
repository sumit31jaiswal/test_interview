enum MessageType { text, image, video, file }

class ChatMessage {
  final int? id;
  final MessageType type;
  final String content;
  final String? thumbnail;
  final String? fileName;
  final int timeStamp;
  final bool isMe;

  ChatMessage({
    this.id,
    required this.type,
    required this.content,
    this.thumbnail,
    this.fileName,
    required this.timeStamp,
    required this.isMe,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'content': content,
      'thumbnail': thumbnail,
      'fileName': fileName,
      'timestamp': timeStamp,
      'isMe': isMe ? 1 : 0,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      type: MessageType.values[map['type']],
      content: map['content'],
      thumbnail: map['thumbnail'],
      fileName: map['fileName'],
      timeStamp: map['timestamp'],
      isMe: map['isMe'] == 1,
    );
  }
}
