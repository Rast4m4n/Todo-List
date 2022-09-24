import 'package:flutter/material.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/states/favorite_switcher.dart';
import 'package:todo_list/domain/states/theme_switcher_notifier.dart';
import 'package:todo_list/navigation/app_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TaskRepository();
  SharedPreferencesRepository();
  ThemeSwitcherNotifier();
  TaskRepository.instance.loadTasks(
    await SharedPreferencesRepository.instance.loadTasks(),
  );
  TaskRepository.instance.loadFavoriteTasks(
    await SharedPreferencesRepository.instance.loadFavoriteTask(),
  );
  ThemeSwitcherNotifier.isDark =
      await SharedPreferencesRepository.instance.loadTheme();
  FavoriteSwitcher();
  FavoriteSwitcher.instance.isFavorite =
      await SharedPreferencesRepository.instance.loadButtonStateFavorite();
  final navigation = AppNavigator();
  runApp(MyApp(navigator: navigation));
}
