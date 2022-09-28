import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/domain/models/task.dart';

class SharedPreferencesRepository {
  static SharedPreferencesRepository? _singleton;
  static SharedPreferencesRepository get instance => _singleton!;

  SharedPreferencesRepository._internal();

  factory SharedPreferencesRepository() {
    _singleton ??= SharedPreferencesRepository._internal();
    return instance;
  }

  final pref = SharedPreferences.getInstance();

  Future<void> saveTask(Task task) async {
    final tasks = await loadTasks();
    tasks.add(task);
    final tasksJson = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await (await pref).setString('tasks', tasksJson);
  }

  Future<List<Task>> loadTasks() async {
    final tasksString = (await pref).getString('tasks') ?? '[]';
    final tasksJson = jsonDecode(tasksString) as List<dynamic>;
    return tasksJson
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<Task> tasks) async {
    final tasksJson = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await (await pref).setString('tasks', tasksJson);
  }

  Future<void> deleteTask(int id) async {
    final tasks = await loadTasks();
    tasks.removeWhere((element) => element.id == id);
    await saveAll(tasks);
  }

  Future<void> editTask(Task task) async {
    final tasks = await loadTasks();
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;
    await saveAll(tasks);
  }
  //------------------Хранение темы-----------------------

  Future<void> saveTheme(bool theme) async {
    await (await pref).setBool('isDark', theme);
  }

  Future<bool> loadTheme() async {
    return (await pref).getBool('isDark') ?? false;
  }
}
