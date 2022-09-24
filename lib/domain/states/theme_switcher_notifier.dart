import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/theme/app_theme.dart';

class ThemeSwitcherNotifier with ChangeNotifier {
  static ThemeSwitcherNotifier? _singleton;
  static ThemeSwitcherNotifier get instance => _singleton!;

  ThemeSwitcherNotifier._internal();

  factory ThemeSwitcherNotifier() {
    _singleton ??= ThemeSwitcherNotifier._internal();
    return instance;
  }

  static bool isDark = false;

  ThemeData currentTheme() {
    return isDark ? AppTheme.dark : AppTheme.light;
  }

  void switchTheme() {
    SharedPreferencesRepository.instance
        .saveTheme(isDark = !isDark)
        .then((value) => notifyListeners());
  }
}
