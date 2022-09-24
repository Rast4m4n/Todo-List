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

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tasks;
  }

  void addTasks(List<Task> tasks) => _tasks.addAll(tasks);

  void editTask(Task task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
  }
}
