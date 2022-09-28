import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/enums/priority_enum.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/navigation/app_navigation.dart';

class ViewModel {
  ViewModel(this.context);
  final BuildContext context;

  void selectPriority(Task task, PriorityEnum selected) async {
    final newTask = task.copyWith(priority: selected);
    TaskRepository.instance.editTask(newTask);
    await SharedPreferencesRepository.instance.editTask(newTask);
  }

  void _favoriteEdit(Task task, bool isFavorite) async {
    final newTask = task.copyWith(isFavorite: isFavorite);
    print('debage ${newTask.isFavorite}');
    TaskRepository.instance.editTask(newTask);
    await SharedPreferencesRepository.instance.editTask(newTask);
  }

  void _addFavorite(Task task) async {
    _favoriteEdit(task, true);
  }

  void _deleteFavorite(Task task) async {
    _favoriteEdit(task, false);
  }

  void onFavoritePressed(Task task) {
    task.isFavorite ? _deleteFavorite(task) : _addFavorite(task);
  }

  void enterViewTask(Task task) {
    Navigator.of(context).pushNamed(
      NavigationRouteNames.viewTaskRoute,
      arguments: task,
    );
  }

  void enterAddTaskPage() {
    Navigator.of(context).pushNamed(NavigationRouteNames.addTaskRoute);
  }

  void deleteTask(int id, int index) async {
    await SharedPreferencesRepository.instance.deleteTask(id);
    TaskRepository.instance.deleteTask(index);
  }
}

class ViewModelInh extends InheritedWidget {
  const ViewModelInh({Key? key, required this.model, required super.child})
      : super(key: key);

  final ViewModel model;

  static ViewModelInh? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ViewModelInh>();
  }

  static ViewModelInh? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<ViewModelInh>()?.widget;
    return widget is ViewModelInh ? widget : null;
  }

  @override
  bool updateShouldNotify(ViewModelInh oldWidget) {
    return model != oldWidget.model;
  }
}
