import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_interview/model/chat_message_model.dart';

class ChatDataBase {
  static Database? _db;
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'chat.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE chat (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT,
          thumbnail TEXT,
          fileName TEXT,
          type INTEGER,
          timestamp INTEGER,
          isMe INTEGER
        )
      ''');
      },
    );
  }

  static Future<List<ChatMessage>> getMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat',
      orderBy: 'timestamp ASC',
    );
    return List.generate(maps.length, (i) => ChatMessage.fromMap(maps[i]));
  }

  static Future<void> insertMessage(ChatMessage message) async {
    final db = await database;
    await db.insert(
      'chat',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> clearChat() async {
    final db = await database;
    await db.delete('chat');
  }
}
