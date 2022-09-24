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

  Future<void> saveFavoriteTask(Task task) async {
    final favoriteTasks = await loadFavoriteTask();
    favoriteTasks.add(task);
    favoriteTasks.map((e) => e.toJson()).toList();
    final favoriteTaskJson = jsonEncode(favoriteTasks);
    await (await pref).setString('favoriteTasks', favoriteTaskJson);
  }

  Future<List<Task>> loadFavoriteTask() async {
    final favoriteTasks = (await pref).getString('favoriteTasks') ?? '[]';
    final favoriteTaskJson = jsonDecode(favoriteTasks) as List<dynamic>;
    return favoriteTaskJson
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveFavoriteAll(List<Task> tasks) async {
    final tasksJson = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await (await pref).setString('favoriteTasks', tasksJson);
  }

  Future<void> deleteFavoriteTask(int id) async {
    final tasks = await loadFavoriteTask();
    tasks.removeWhere((element) => element.id == id);
    await saveFavoriteAll(tasks);
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

  Future<void> editTasks(Task task) async {
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

  //----------------Сохранение и загрузка избранных задача---------------------

  Future<void> saveButtonStateFavorite(bool favorite) async {
    await (await pref).setBool('isFavorite', favorite);
  }

  Future<bool> loadButtonStateFavorite() async {
    return (await pref).getBool('isFavorite') ?? false;
  }
}
