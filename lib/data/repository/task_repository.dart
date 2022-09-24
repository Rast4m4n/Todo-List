import 'dart:math';

import 'package:todo_list/domain/models/task.dart';

class TaskRepository {
  static TaskRepository? _singleton;
  static TaskRepository get instance => _singleton!;

  TaskRepository._internal();

  factory TaskRepository() {
    _singleton ??= TaskRepository._internal();
    return _singleton!;
  }

  final List<Task> _tasks = [];
  final List<Task> _favoriteTasks = [];

  Future<List<Task>> getTasks() async {
    Future.delayed(const Duration(seconds: 1));
    return _tasks;
  }

  Future<List<Task>> getFavoriteTasks() async {
    Future.delayed(const Duration(seconds: 1));
    return _favoriteTasks;
  }

  void loadTasks(List<Task> tasks) => _tasks.addAll(tasks);

  void loadFavoriteTasks(List<Task> tasks) {
    _favoriteTasks.addAll(tasks);
  }

  Task addToFavoriteTask(Task task) {
    _favoriteTasks.add(task);
    return task;
  }

  Task createTask({
    required String title,
    required String description,
  }) {
    final lastId =
        _tasks.isEmpty ? 0 : _tasks.map((task) => task.id).reduce(max);
    final task = Task(
      title: title,
      description: description,
      id: lastId + 1,
    );
    _tasks.add(task);
    return task;
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
  }

  void deleteFavoriteTask(int index) {
    _favoriteTasks.removeWhere((element) => element.id == index);
  }

  void editTask(Task task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
  }
}
