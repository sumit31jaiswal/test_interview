import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_interview/data/chat_database.dart';
import 'package:test_interview/model/chat_message_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatController extends GetxController {
  final message = <ChatMessage>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    loadMessage();
    super.onInit();
  }

  Future loadMessage() async {
    message.value = await ChatDataBase.getMessages();
  }

  Future<void> sendText(String text) async {
    final msg = ChatMessage(
      type: MessageType.text,
      content: text,
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      isMe: true,
    );
    await ChatDataBase.insertMessage(msg);
    message.add(msg);
  }

  Future sendMedia({
    required String path,
    required MessageType type,
    String? fileName,
  }) async {
    isLoading.value = true;
    String? thumbnail;
    if (type == MessageType.video) {
      thumbnail = await VideoThumbnail.thumbnailFile(
        video: path,
        thumbnailPath: (await getApplicationDocumentsDirectory()).path,
      );
    }
    final msg = ChatMessage(
      type: type,
      content: path,
      thumbnail: thumbnail,
      fileName: fileName,
      timeStamp: DateTime.now().microsecondsSinceEpoch,
      isMe: true,
    );
    await ChatDataBase.insertMessage(msg);
    message.add(msg);
    isLoading.value = false;
  }

  void clearChat() async {
    await ChatDataBase.clearChat();
    message.clear();
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      type: FileType.custom,
    );
    if (result != null) {
      sendMedia(
        type: MessageType.file,
        path: result.files.single.path!,
        fileName: result.files.single.name,
      );
    }
  }
}
