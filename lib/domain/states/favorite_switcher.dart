import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/models/task.dart';

class FavoriteSwitcher {
  void _favoriteEdit(Task task, bool isFavorite) async {
    final newTask = task.copyWith(isFavorite: isFavorite);
    TaskRepository.instance.editTask(newTask);
    await SharedPreferencesRepository.instance.editTask(newTask);
  }

  void addFavorite(Task task) async {
    _favoriteEdit(task, true);
  }

  void deleteFavorite(Task task) async {
    _favoriteEdit(task, false);
  }
}

class FavoriteSwitcherInh extends InheritedWidget {
  final FavoriteSwitcher? model;
  const FavoriteSwitcherInh(
      {Key? key, required this.model, required super.child})
      : super(key: key);
  static FavoriteSwitcherInh? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoriteSwitcherInh>();
  }

  @override
  bool updateShouldNotify(FavoriteSwitcherInh oldWidget) {
    return model != oldWidget.model;
  }
}
