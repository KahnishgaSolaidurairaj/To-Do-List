import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoStorage {
  Future<List<dynamic>> loadTasks(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data == null ? [] : jsonDecode(data);
  }

  Future<void> saveTasks(String key, List tasks) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(tasks));
  }
}
