import 'package:flutter/material.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/ui/home/taskList/task_list_page.dart';
import 'package:todo_list/ui/task_management/add_task_page.dart';
import 'package:todo_list/ui/task_management/editing_task_page.dart';
import 'package:todo_list/ui/task_management/view_task.dart';

abstract class NavigationRouteNames {
  static const taskRoute = '/';
  static const editingTaskRoute = '/editingTask';
  static const addTaskRoute = '/AddTask';
  static const viewTaskRoute = '/viewTask';
}

class AppNavigator {
  String get initialRoute => NavigationRouteNames.taskRoute;

  Map<String, Widget Function(BuildContext)> get routes => {
        NavigationRouteNames.taskRoute: (context) => const TasksListPage(),
        NavigationRouteNames.addTaskRoute: (context) => const AddTaskPage(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final task = settings.arguments as Task;
    if (settings.name!.startsWith(NavigationRouteNames.editingTaskRoute)) {
      return MaterialPageRoute(
        builder: (context) {
          return EditingTaskPage(task: task);
        },
      );
    }
    if (settings.name!.startsWith(NavigationRouteNames.viewTaskRoute)) {
      return MaterialPageRoute(
        builder: (context) {
          return ViewTaskPage(task: task);
        },
      );
    }
    return null;
  }
}
