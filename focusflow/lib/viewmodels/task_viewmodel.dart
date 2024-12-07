import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../utils/database_helper.dart';

class TaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> loadTasks() async {
    _tasks.clear();
    _tasks.addAll(await _dbHelper.getTasks());
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await loadTasks();
  }
}
