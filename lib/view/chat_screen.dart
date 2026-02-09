import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:test_interview/view/widget/message_widget.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatController _chatController = Get.put(ChatController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ever(_chatController.message, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat Screen'),
          actions: [
            IconButton(
              onPressed: () {
                _chatController.clearChat();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (_chatController.isLoading.value &&
                        index == _chatController.message.length) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return MessageBubble(
                      message: _chatController.message[index],
                    );
                  },
                  itemCount:
                      _chatController.message.length +
                      (_chatController.isLoading.value ? 1 : 0),
                  shrinkWrap: true,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _chatController.pickFile();
                  },
                  icon: Icon(Icons.attach_file),
                ),

                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final vid = await ImagePicker().pickVideo(
                            source: ImageSource.gallery,
                          );
                          if (vid != null) {
                            _chatController.sendMedia(
                              path: vid.path,
                              type: MessageType.video,
                            );
                          }
                        },
                        icon: Icon(Icons.video_call),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final img = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (img != null) {
                      _chatController.sendMedia(
                        path: img.path,
                        type: MessageType.image,
                      );
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _chatController.sendText(_controller.text);
                      _controller.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
