import 'package:flutter/material.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/states/theme_switcher_notifier.dart';
import 'package:todo_list/navigation/app_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TaskRepository();
  SharedPreferencesRepository();
  // await SharedPreferencesRepository.instance.saveAll([]);
  ThemeSwitcherNotifier();

  TaskRepository.instance.addTasks(
    await SharedPreferencesRepository.instance.loadTasks(),
  );

  ThemeSwitcherNotifier.isDark =
      await SharedPreferencesRepository.instance.loadTheme();

  final navigation = AppNavigator();
  runApp(MyApp(navigator: navigation));
}
